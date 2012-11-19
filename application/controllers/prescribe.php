<?php //if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once ("secure_area.php");
class Prescribe extends Secure_area {

	
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
		$data['invoice_id'] = $this->input->post('invoice_id');
		//$this->load->model('item');
		if(!$this->Item->exists($item_id))
		{
			//try to get item id given an item_number
			//no this is useless, what exactly is being submitted????
			$item_id = $this->Item->get_item_id($item_id);

			if(!$item_id)
				$this->_reload();
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
	// function add_prescription()
	// {
	// 	if ($this->input->post('invoice_id')) {
	// 		////////////////////////
	// 		$dosage = $this->input->post('number') * $this->input->post('frequency') * $this->input->post('duration');
	// 		$invoice_item_data = array(
	// 			'invoice_id' => $this->input->post('invoice_id'),
	// 			'item_id' =>$this->input->post('item_id'),
	// 			'description' => "",
	// 			'serialnumber' =>"",
	// 			'line' => 1,
	// 			'quantity_purchased' => $dosage,
	// 			'item_cost_price' => 0.00,
	// 			'item_unit_price' => 0.00,
	// 			'discount_percent' => 0,
	// 			//'route_of_adm' => $this->input->post('roa'),
	// 			'frequency' => $this->input->post('frequency'),
	// 			'dosage' => $dosage,
	// 			'duration' => $this->input->post('duration')
	// 		);

	// 		$result = $this->Prescribe_model->update_prescription_items($invoice_item_data);
	// 		$data['invoice_id'] = $this->input->post('invoice_id');
	// 		if (!$result)
	// 		{
	// 			$data['error_message'] = $this->lang->line('invoices_transaction_failed');
	// 		}else{
	// 			$quantity_in_stock=$this->Item->get_info($this->input->post('item_id'))->quantity;
	// 			$new_quantity = $quantity_in_stock - $dosage;
	// 			$item_data = array('quantity' => $new_quantity);
	// 			$new_result = $this->Item->save($item_data, $this->input->post('item_id'));
	// 			if ($new_result) {
	// 				$data['success'] = $this->lang->line('prescription_added_succesfully');
	// 			}else{
	// 				$data['error_message'] = $this->lang->line('invoices_transaction_failed');

	// 			}
				
	// 		}
	// 		$this->_reload($data);
	// 		/////////////////////////
	// 		// echo "test";
	// 	} else{
	// 		///////////////
	// 			$invoice_data = array(
	// 			'invoice_time' => date('Y-m-d H:i:s'),
	// 			'customer_id' =>  $this->prescription_lib->get_customer(),
	// 			'employee_id' => $this->Employee->get_logged_in_employee_info()->person_id,
	// 			'comment' => 'None',
	// 			'amount' => 0,
	// 			'processed' => 0
	// 			);
	// 		//print_r($invoice_data);
	// 		$dosage = $this->input->post('number') * $this->input->post('frequency') * $this->input->post('duration');
	// 		$invoice_item_data = array(
	// 			'item_id' =>$this->input->post('item_id'),
	// 			'description' => "",
	// 			'serialnumber' =>"",
	// 			'line' => 1,
	// 			'quantity_purchased' => $dosage,
	// 			'item_cost_price' => 0.00,
	// 			'item_unit_price' => 0.00,
	// 			'discount_percent' => 0,
	// 			//'route_of_adm' => $this->input->post('roa'),
	// 			'frequency' => $this->input->post('frequency'),
	// 			'dosage' => $dosage,
	// 			'duration' => $this->input->post('duration')
	// 			);
	// 		$data['invoice_id'] = $this->Prescribe_model->save_prescription($invoice_data, $invoice_item_data);
	// 		if ($data['invoice_id'] == 'Invoice -1')
	// 		{
	// 			$data['error_message'] = $this->lang->line('invoices_transaction_failed');
	// 		}else{
	// 			$quantity_in_stock=$this->Item->get_info($this->input->post('item_id'))->quantity;
	// 			$new_quantity = $quantity_in_stock - $dosage;
	// 			$item_data = array('quantity' => $new_quantity);
	// 			$new_result = $this->Item->save($item_data, $this->input->post('item_id'));
	// 			if ($new_result) {
	// 				$data['success'] = $this->lang->line('prescription_added_succesfully');
	// 			}else{
	// 				$data['error_message'] = $this->lang->line('invoices_transaction_failed');

	// 			}
	// 			// $data['success'] = $this->lang->line('prescription_added_succesfully');
	// 		}
	// 		$this->_reload($data);
	// 			///////////////
	// 	}
		
	// }
	function add()
	{
		$data = array();
		//creates cart session data if not exists
		if (!$this->session->userdata('presc_cart')) {
				$this->session->set_userdata('presc_cart', array());
		}
		//get current items in cart
		$current_cart = $this->session->userdata('presc_cart');
		$insertkey = count($current_cart) + 1;
		if (!count($current_cart)) {
			$insertkey = 0;
		}
		//update them
		$dosage = $this->input->post('number') * $this->input->post('frequency') * $this->input->post('duration');
		$item_id = $this->input->post('item_id');
		$new_items = array(
			'insertkey' => $insertkey,
			'item_id' =>$item_id,
			'time' => date('Y-m-d h:i:s'),
			'dosage' => $dosage,
			'name'=>$this->Item->get_info($item_id)->name,
			'frequency' => $this->input->post('frequency'),
			'duration' => $this->input->post('duration')
			);
		$current_cart[] = $new_items;
		//save the items to cookie
		$this->session->set_userdata('presc_cart',$current_cart);
		//reload view with new data
		$data['cart'] = $current_cart;

		$this->_reload($data);
	}

	function delete($insertkey=0)
	{
		if ($insertkey < 0 || '') {
			$this->_reload();
		}else{
			//get current cart
			$current_cart = $this->session->userdata('presc_cart');
			//remove selected item from cart 
			unset($current_cart[$insertkey]);
			//save new cart to session
			$this->session->set_userdata('presc_cart',$current_cart);
			//reload page
			$this->_reload($data);
		}	
	}

	//save to db, shida zingine ziko hapa
	function complete()
	{
		if (!$this->session->userdata('presc_cart')) {
				$this->reload();
		}else{
			$current_cart = $this->session->userdata('presc_cart');
			$invoice_data = array(
				'invoice_time' => date('Y-m-d H:i:s'),
				'customer_id' =>  $this->prescription_lib->get_customer(),
				'employee_id' => $this->Employee->get_logged_in_employee_info()->person_id,
				'comment' => 'None',
				'amount' => 0,
				'processed' => 0
			);
			//save values to db and take care of the pre processing of items
			//unset all values from session and allow new one to start and reload page
			$data['invoice_id'] = $this->Prescribe_model->save_cart($invoice_data, $current_cart);
			if ($data['invoice_id'] == 'Invoice -1')
			{
				$data['error_message'] = $this->lang->line('invoices_transaction_failed');
			}else{
				unset($current_cart);
				$this->session->set_userdata('presc_cart',$current_cart);
				$data['success'] = $this->lang->line('prescription_added_succesfully');
			}
			$this->_reload($data);

		}
	}
	function remove_customer()
	{
		$this->prescription_lib->delete_customer();
		$this->_reload();
	}


	function _reload($data=array())
	{
		$person_info = $this->Employee->get_logged_in_employee_info();
		$data['modes']=array('sale'=>$this->lang->line('invoices_invoice'),'return'=>$this->lang->line('invoices_return'));
		$data['mode']=$this->prescription_lib->get_mode();
		$data['items_module_allowed'] = $this->Employee->has_permission('items', $person_info->person_id);
		//Alain Multiple Payments
		$customer_id=$this->prescription_lib->get_customer();
		$data['histories'] = $this->Prescribe_model->get_prescriptions_for_customer($customer_id);
		//need to get customer data about prescriptions
		//$data['prescriptions'] = $this->Prescribe_model->get_prescriptions_for_customer($customer_id);
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
		//load cart items
		$data['cart'] = $this->session->userdata('presc_cart');
		$this->load->view("prescribe/prescribe_view", $data);
	}

}

/* End of file Docprescribe.php */
/* Location: ./application/controllers/Docprescribe.php */
