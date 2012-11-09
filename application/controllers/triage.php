<?php
require_once ("person_controller.php");
class Triage extends Person_controller
{
	function __construct()
	{
		parent::__construct('triage');
	}
	
	function index()
	{
		$config['base_url'] = site_url('/triage/index');
		$config['total_rows'] = $this->Customer->count_all_triage();
		$config['per_page'] = '20';
		$config['uri_segment'] = 3;
		$this->pagination->initialize($config);
		
		$data['controller_name']=strtolower(get_class());
		$data['form_width']=$this->get_form_width();
		$data['manage_table']=get_triage_manage_table( $this->Customer->get_all_triage( $config['per_page'], $this->uri->segment( $config['uri_segment'] ) ), $this );
		$this->load->view('triage/manage',$data);
	}
	
	/*
	Returns customer table data rows. This will be called with AJAX.
	*/
	function search()
	{
		$search=$this->input->post('search');
		$data_rows=get_people_manage_table_data_rows($this->Customer->search($search),$this);
		echo $data_rows;
	}
	
	/*
	Gives search suggestions based on what is being searched for
	*/
	function suggest()
	{
		$suggestions = $this->Customer->get_search_suggestions($this->input->post('q'),$this->input->post('limit'));
		echo implode("\n",$suggestions);
	}
	
	/*
	Loads the customer edit form
	*/
	function view($customer_id=-1)
	{
		$data['triage_info']=$this->Customer->get_info_triage($customer_id);
		$this->load->view("triage/form",$data);
	}
	
	/*
	Inserts a customer
	*/
	function save($customer_id=-1)
	{
		//get employee details
			$person_info = $this->Employee->get_logged_in_employee_info();
			$staff_attendant = $person_info->username;
		//load date
			$datestring = "%Y-%m-%d %h:%i:%a";
			$date = mdate($datestring);
		$person_data = array(
		'triage_id' => '',
		'patient_id'=> $customer_id,
		'blood_pressure'=>$this->input->post('blood_pressure'),
		'pulse_rate'=>$this->input->post('pulse_rate'),
		'temperature'=>$this->input->post('temperature'),
		'weight'=>$this->input->post('weight'),
		'general_appearance'=>$this->input->post('general_appearance'),
		'chief_complaint'=>$this->input->post('chief_complaint'),
		'staff_attendant' => $staff_attendant,
		'date_entered' => $date
		);
		if($this->Customer->save_triage($person_data,$customer_id))
		{
			echo json_encode(array('success'=>true,'message'=>$this->lang->line('triage_successful_adding').' '.
			$person_data['patient_id']));
		}
		else//failure
		{	
			echo json_encode(array('success'=>false,'message'=>$this->lang->line('triage_error_adding_updating').' '.
			$person_data['patient_id']));
		}
	}


	
	/*
	This deletes customers from the customers table
	*/
	function delete()
	{
		$customers_to_delete=$this->input->post('ids');
		
		if($this->Customer->delete_list($customers_to_delete))
		{
			echo json_encode(array('success'=>true,'message'=>$this->lang->line('triage_successful_deleted').' '.
			count($customers_to_delete).' '.$this->lang->line('triage_one_or_multiple')));
		}
		else
		{
			echo json_encode(array('success'=>false,'message'=>$this->lang->line('triage_cannot_be_deleted')));
		}
	}
	
	function excel()
	{
		$data = file_get_contents("import_customers.csv");
		$name = 'import_customers.csv';
		force_download($name, $data);
	}
	
	function excel_import()
	{
		$this->load->view("triage/excel_import", null);
	}

	function do_excel_import()
	{
		$msg = 'do_excel_import';
		$failCodes = array();
		if ($_FILES['file_path']['error']!=UPLOAD_ERR_OK)
		{
			$msg = $this->lang->line('items_excel_import_failed');
			echo json_encode( array('success'=>false,'message'=>$msg) );
			return;
		}
		else
		{
			if (($handle = fopen($_FILES['file_path']['tmp_name'], "r")) !== FALSE)
			{
				//Skip first row
				fgetcsv($handle);
				
				$i=1;
				while (($data = fgetcsv($handle)) !== FALSE) 
				{
					$person_data = array(
					'first_name'=>$data[0],
					'last_name'=>$data[1],
					'email'=>$data[2],
					'phone_number'=>$data[3],
					'address_1'=>$data[4],
					'address_2'=>$data[5],
					'city'=>$data[6],
					'state'=>$data[7],
					'zip'=>$data[8],
					'country'=>$data[9],
					'comments'=>$data[10]
					);
					
					$customer_data=array(
					'account_number'=>$data[11]=='' ? null:$data[11],
					'taxable'=>$data[12]=='' ? 0:1,
					);
					
					if(!$this->Customer->save($person_data,$customer_data))
					{	
						$failCodes[] = $i;
					}
					
					$i++;
				}
			}
			else 
			{
				echo json_encode( array('success'=>false,'message'=>'Your upload file has no data or not in supported format.') );
				return;
			}
		}

		$success = true;
		if(count($failCodes) > 1)
		{
			$msg = "Most triage results imported. But some were not, here is list of their CODE (" .count($failCodes) ."): ".implode(", ", $failCodes);
			$success = false;
		}
		else
		{
			$msg = "Import triage results successful";
		}

		echo json_encode( array('success'=>$success,'message'=>$msg) );
	}
	
	/*
	get the width for the add/edit form
	*/
	function get_form_width()
	{			
		return 350;
	}
}
?>