<?php //if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once ("secure_area.php");
class Dispense extends Secure_area {

	
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
	
	

	function remove_customer()
	{
		$this->prescription_lib->delete_customer();
		$this->_reload();
	}


	function _reload($data=array())
	{
		$person_info = $this->Employee->get_logged_in_employee_info();
		$data['items_module_allowed'] = $this->Employee->has_permission('items', $person_info->person_id);
		$customer_id=$this->prescription_lib->get_customer();
		$data['histories'] = $this->Dispensing_model->get_prescriptions_for_customer($customer_id);
		//need to get customer data about prescriptions
		$data['prescriptions'] = $this->Dispensing_model->get_customer_history($customer_id);
		if($customer_id!=-1)
		{
			$info=$this->Customer->get_info($customer_id);
			$data['customer']=$info->first_name.' '.$info->last_name;
			$data['gender'] = $info->gender;
			$data['age'] = $info->age;
			$data['patient_no'] = "MLKH".$customer_id;
			$data['civil_status'] = $info->civil_status;
		}
		$this->load->view("dispense/dispense_view", $data);
	}

}

/* End of file Dispense.php */
/* Location: ./application/controllers/Docprescribe.php */
