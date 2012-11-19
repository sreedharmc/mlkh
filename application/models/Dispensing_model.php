<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dispensing_model extends CI_Model {

	public function get_prescriptions_for_customer($customer_id)
	{
		$this->db->where('customer_id', $customer_id);
		$this->db->where('processed', 0);
		$q = $this->db->get('prescribed');
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
