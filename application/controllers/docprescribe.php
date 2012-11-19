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
		$suggestions = $this->Prescribe_model->get_item_search_suggestions($this->input->post('q'),$this->input->post('limit'));
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
	
	function select_item($item_id = 0)
	{
		$data=array();
		$item_id = $this->input->post("item");
		//$this->load->model('item');
		if(!$this->Item->exists($item_id))
		{
			//try to get item id given an item_number
			//no this is useless, what exactly is being submitted????
			$item_id = $this->Item->get_item_id($item_id);

			if(!$item_id)
				return false;
		}else{

			$data['item'] = array(
				'item_id'=>$item_id,
				'name'=>$this->Item->get_info($item_id)->name,
				'item_number'=>$this->Item->get_info($item_id)->item_number,
				);
			

			// $data['error']=$this->lang->line('invoices_unable_to_add_item');
			// $data['warning'] = $this->lang->line('invoices_quantity_less_than_zero');

			$this->_reload($data);
		}
	}
	function add_prescription()
	{
		$invoice_data = array(
			'invoice_time' => date('Y-m-d H:i:s'),
			'customer_id' =>  $this->prescription_lib->get_customer(),
			'employee_id' => $this->Employee->get_logged_in_employee_info()->person_id,
			'comment' => 'None',
			'amount' => 0,
			'processed' => 0
			);
		//print_r($invoice_data);
		$invoice_item_data = array(
			'item_id' =>$this->input->post('item_id'),
			'description' => "",
			'serialnumber' =>"",
			'line' => 1,
			'quantity_purchased' => 0.00,
			'item_cost_price' => 0.00,
			'item_unit_price' => 0.00,
			'discount_percent' => 0,
			'route_of_adm' => $this->input->post('roa'),
			'frequency' => $this->input->post('frequency'),
			'dosage' => $this->input->post('dosage'),
			'duration' => $this->input->post('duration')
			);
		$data['invoice_id'] = $this->Prescribe_model->save_prescription($invoice_data, $invoice_item_data);
		if ($data['invoice_id'] == 'Invoice -1')
		{
			$data['error_message'] = $this->lang->line('invoices_transaction_failed');
		}else{
			$data['success'] = $this->lang->line('prescription_added_succesfully');
		}
		$this->_reload($data);
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
		//$data['cart']=$this->prescription_lib->get_cart();
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
		//$data['cart']=$this->prescription_lib->get_cart();
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
		$data['prescriptions'] = $this->Prescribe_model->get_prescriptions_for_customer($customer_id);
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
