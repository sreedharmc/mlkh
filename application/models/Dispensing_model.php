<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dispensing_model extends CI_Model {

	public function get_customer_history($customer_id)
	{
		$this->db->where('customer_id', $customer_id);
		$this->db->where('processed', 2);
		$this->db->order_by("invoice_time", "desc"); 
		$q = $this->db->get('prescription_history');
		if ($q->num_rows() > 0) {
			foreach ($q->result() as $row) {
				$data[] = $row;
			}
			return $data ;
		}
	}
	public function get_prescriptions_for_customer($customer_id)
	{
		$this->db->where('customer_id', $customer_id);
		$this->db->where('processed', 1);
		$this->db->order_by("invoice_time", "desc"); 
		// $this->db->where('processed', 1);//check this in prescribe model to show most relevant
		$q = $this->db->get('prescription_history');
		if ($q->num_rows() > 0) {
			foreach ($q->result() as $row) {
				$data[] = $row;
			}
			return $data ;
		}
	}
	public function get_invoice_id_by_customer_id($customer_id ='-1')
	{
		if ($customer_id == '-1') {
			return FALSE;
		}else{
			$this->db->where('customer_id', $current_id);
			$this->db->where('processed', 1);
			$q = $this->db->get('invoices');
			if ($q->num_rows() > 0)
			{
			   $row = $query->row(); 

			   return $row->invoice_id;
			}
		}
	}
	public function update_prescription_invoice($invoice_data, $customer_id = '-1')
	{
		if ($customer_id == '-1' || FALSE) {
			return FALSE;
		}else{
			$this->db->trans_start();
			$this->db->where('customer_id', $customer_id);
			$this->db->where('processed', 1);
			$this->db->update('invoices', $invoice_data); 
			$this->db->trans_complete();
			if ($this->db->affected_rows() > 0) {
				return TRUE;
			}else{
				return FALSE;
			}
		}
	}

}

/* End of file Dispensing_model.php */
/* Location: ./application/models/Dispensing_model.php */
