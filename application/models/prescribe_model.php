<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Prescribe_model extends Invoice {

	public function get_info_by_id($id)
	{
		$q = $this->db->get_where('invoices_items',array('item_id'=>$id));
		if ($q->num_rows() > 0) {
			
			return $row = $q->row();
		}
	}
	public function get_all_routes_of_adm()
	{
		$q = $this->db->get('route_of_admin');
		if ($q->num_rows() > 0) {
			foreach ($q->result_array() as $row) {
				$data[$row['route_id']] = $row['name'];
			}
			return $data;
		}
	}

	public function get_all_frequencies()
	{
		$q = $this->db->get('frequency');
		if ($q->num_rows() > 0) {
			foreach ($q->result_array() as $row) {
				$data[$row['frequency_id']] = $row['frequency_name'];
			}
			return $data;
		}
	}

	function save ($items,$customer_id,$employee_id,$comment="",$payments,$invoice_id=false)
	{
		if(count($items)==0)
			return -1;

		//Alain Multiple payments
		//Build payment types string

		$invoices_data = array(
			'invoice_time' => date('Y-m-d H:i:s'),
			'customer_id'=> $this->Customer->exists($customer_id) ? $customer_id : null,
			'employee_id'=>$employee_id,
			'amount'=>$payments,
			'comment'=>$comment
		);

		//Run these queries as a transaction, we want to make sure we do all or nothing
		$this->db->trans_start();
		
		if ($this->already_invoiced($customer_id)){
			$invoice_id = $this->already_invoiced($customer_id);
			$this->update($invoices_data,$invoice_id);
			
			$this->db->where('invoice_id', $invoice_id);
			$this->db->delete("invoices_items");
		}
		else{
			$this->db->insert('invoices',$invoices_data);
			$invoice_id = $this->db->insert_id();
		}


		foreach($items as $line=>$item)
		{
			$cur_item_info = $this->Item->get_info($item['item_id']);

			$invoices_items_data = array
			(
				'invoice_id'=>$invoice_id,
				'item_id'=>$item['item_id'],
				'line'=>$item['line'],
				'description'=>$item['description'],
				'serialnumber'=>$item['serialnumber'],
				'quantity_purchased'=>$item['quantity'],
				'item_cost_price' => $cur_item_info->cost_price,
				'item_unit_price'=>$item['price'],
				'dosage' => $item['dosage'],
				'route_of_adm' => $item['roa'],
				'frequency' => $item['frequency'],
				'duration'	=> $item['duration']
			);
			
			$this->db->insert('invoices_items',$invoices_items_data);

		}
		$this->db->trans_complete();
		
		if ($this->db->trans_status() === FALSE)
		{
			return -1;
		}
		
		return $invoice_id;
	}
}

/* End of file prescribe_model.php */
/* Location: ./application/models/prescribe_model.php */
