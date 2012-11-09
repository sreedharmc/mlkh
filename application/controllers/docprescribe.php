<?php //if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once ("secure_area.php");
class Docprescribe extends Secure_area {

	
	function __construct()
	{
		parent::__construct('invoices');
		$this->load->library('prescription_lib');
	}

	function index()
	{
		$this->_reload();
	}

	function item_search()
	{
		$suggestions = $this->Item->get_item_search_suggestions($this->input->post('q'),$this->input->post('limit'));
		echo implode("\n",$suggestions);
	}

	function customer_search()
	{
		$suggestions = $this->Customer->get_customer_search_suggestions($this->input->post('q'),$this->input->post('limit'));
		echo implode("\n",$suggestions);
	}

	function select_customer($customer_id = 0)
	{
		if ( !$customer_id )
		{
			if ( $this->input->post("customer") )
			{ 
				$customer_id = $this->input->post("customer");
				$employee_id=$this->Employee->get_logged_in_employee_info()->person_id;
				$this->prescription_lib->set_customer($customer_id);
				$this->prescription_lib->get_invoice($customer_id,$employee_id);
			}
		}
		
		else 
		{
			if ($this->Customer->customer_exists($customer_id) == 1) 
			{
				$employee_id=$this->Employee->get_logged_in_employee_info()->person_id;
				$this->prescription_lib->set_customer($customer_id);
				$this->prescription_lib->get_invoice($customer_id,$employee_id);
			}
		}
		
		$this->_reload();
	}
	
	function add()
	{
		$data=array();
		$mode = $this->prescription_lib->get_mode();
		$item_id_or_number_or_receipt = $this->input->post("item");
		$quantity = $mode=="sale" ? 1:-1;

		if($this->prescription_lib->is_valid_receipt($item_id_or_number_or_receipt) && $mode=='return')
		{
			$this->prescription_lib->return_entire_invoice($item_id_or_number_or_receipt);
		}
		elseif(!$this->prescription_lib->add_item($item_id_or_number_or_receipt,$quantity))
		{
			$data['error']=$this->lang->line('invoices_unable_to_add_item');
		}
		
		if($this->prescription_lib->out_of_stock($item_id_or_number_or_receipt))
		{
			$data['warning'] = $this->lang->line('invoices_quantity_less_than_zero');
		}
		$this->_reload($data);
	}

	function edit_item($line)
	{
		$data= array();

		//$this->form_validation->set_rules('price', 'lang:items_price', 'required|numeric');
		//$this->form_validation->set_rules('quantity', 'lang:items_quantity', 'required|numeric');

        $description = $this->input->post("description");
        $serialnumber = $this->input->post("serialnumber");
		$price = $this->input->post("price");
		$quantity = $this->input->post("quantity");
		$discount = $this->input->post("discount");


		if ($this->form_validation->run() != FALSE)
		{
			$this->prescription_lib->edit_item($line,$description,$serialnumber,$quantity,$discount,$price);
		}
		else
		{
			$data['error']=$this->lang->line('invoices_error_editing_item');
		}
		
		if($this->prescription_lib->out_of_stock($this->prescription_lib->get_item_id($line)))
		{
			$data['warning'] = $this->lang->line('invoices_quantity_less_than_zero');
		}


		$this->_reload($data);
	}

	function delete_item($item_number)
	{
		$this->prescription_lib->delete_item($item_number);
		$this->_reload();
	}

	function remove_customer()
	{
		$this->prescription_lib->delete_customer();
		$this->_reload();
	}

	function complete()
	{
		$data['cart']=$this->prescription_lib->get_cart();
		//print_r($data['cart']);
		$data['subtotal']=$this->prescription_lib->get_subtotal();
		$data['total']=$this->prescription_lib->get_total();
		$data['receipt_title']=$this->lang->line('invoice_receipt');
		$data['transaction_time']= date('m/d/Y h:i:s a');
		$customer_id=$this->prescription_lib->get_customer();
		$employee_id=$this->Employee->get_logged_in_employee_info()->person_id;
		$comment = $this->input->post('comment');
		$emp_info=$this->Employee->get_info($employee_id);
		$data['employee']=$emp_info->first_name.' '.$emp_info->last_name;

		if($customer_id!=-1)
		{
			$cust_info=$this->Customer->get_info($customer_id);
			$data['customer']=$cust_info->first_name.' '.$cust_info->last_name;
		}

		

		//SAVE invoice to database
		$data['invoice_id']='Invoice '.$this->Prescribe_model->save($data['cart'], $customer_id,$employee_id,$comment,$data['total']);
		if ($data['invoice_id'] == 'Invoice -1')
		{
			$data['error_message'] = $this->lang->line('invoices_transaction_failed');
		}
		$this->load->view("docprescribe",$data);
		$this->prescription_lib->clear_all();
	}

	function receipt($invoice_id)
	{
		$invoice_info = $this->Invoice->get_invoice($invoice_id)->row_array();
		$this->prescription_lib->copy_entire_invoice($invoice_id);
		$data['cart']=$this->prescription_lib->get_cart();
		$data['subtotal']=$this->prescription_lib->get_subtotal();
		$data['total']=$this->prescription_lib->get_total();
		$data['receipt_title']=$this->lang->line('invoices_receipt');
		$data['transaction_time']= date('m/d/Y h:i:s a', strtotime($invoice_info['invoice_time']));
		$customer_id=$this->prescription_lib->get_customer();
		$employee_id=$this->Employee->get_logged_in_employee_info()->person_id;
		$emp_info=$this->Employee->get_info($employee_id);
		$data['employee']=$emp_info->first_name.' '.$emp_info->last_name;

		if($customer_id!=-1)
		{
			$cust_info=$this->Customer->get_info($customer_id);
			$data['customer']=$cust_info->first_name.' '.$cust_info->last_name;
		}
		$data['invoice_id']='Invoice '.$invoice_id;
		$this->load->view("invoices/receipt",$data);
		$this->prescription_lib->clear_all();

	}

	function _reload($data=array())
	{
		$person_info = $this->Employee->get_logged_in_employee_info();
		$data['cart']=$this->prescription_lib->get_cart();
		//print_r($data['cart']);
		$data['modes']=array('sale'=>$this->lang->line('invoices_invoice'),'return'=>$this->lang->line('invoices_return'));
		$data['mode']=$this->prescription_lib->get_mode();
		$data['subtotal']=$this->prescription_lib->get_subtotal();
		$data['taxes']=$this->prescription_lib->get_taxes();
		$data['total']=$this->prescription_lib->get_total();
		$data['items_module_allowed'] = $this->Employee->has_permission('items', $person_info->person_id);
		//Alain Multiple Payments
		$data['payments_total']=$this->prescription_lib->get_payments_total();
		$data['amount_due']=$this->prescription_lib->get_amount_due();

		$customer_id=$this->prescription_lib->get_customer();
		if($customer_id!=-1)
		{
			$info=$this->Customer->get_info($customer_id);
			$data['customer']=$info->first_name.' '.$info->last_name;
			$data['gender'] = $info->gender;
			$data['age'] = $info->age;
			$data['patient_no'] = "MLKH".$customer_id;
			$data['civil_status'] = $info->civil_status;
		}
		$data['roa'] = $this->Prescribe_model->get_all_routes_of_adm();
		$data['frequency'] = $this->Prescribe_model->get_all_frequencies();
		$this->load->view("prescription/prescription_view", $data);
	}

    function cancel_invoice()
    {
    	$this->prescription_lib->clear_all();
    	$this->_reload();

    }

}

/* End of file Docprescribe.php */
/* Location: ./application/controllers/Docprescribe.php */
