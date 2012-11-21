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

}

/* End of file Dispensing_model.php */
/* Location: ./application/models/Dispensing_model.php */
