<?php $this->load->view("partial/header"); ?>
<div id="page_title" style="margin-bottom:8px;"><?php echo $this->lang->line('prescription'); ?></div>
<?php
if(isset($error))
{
	echo "<div class='error_message'>".$error."</div>";
}

if (isset($warning))
{
	echo "<div class='warning_mesage'>".$warning."</div>";
}

if (isset($success))
{
	echo "<div class='success_message'>".$success."</div>";
}
?>
<div id="register_wrapper">
<?php echo form_open("prescribe/select_item",array('id'=>'add_item_form')); ?>
<?php if (isset($invoice_id)): ?>
			<?php echo form_hidden('invoice_id', $invoice_id); ?>
<?php endif ?>
<label id="item_label" for="item">

<?php
echo $this->lang->line('invoices_find_or_scan_item');
?>
</label>
<?php echo form_input(array('name'=>'item','id'=>'item','value'=>"".$item['name'].""));?>

</form>

<table >
<thead>
<tr>
<th style="width:10%;"><?php echo $this->lang->line('presctiption_item_name'); ?></th>
<th style="width:10%;"><?php echo $this->lang->line('prescription_number_of_items'); ?></th>
<th style="width:15%;"><?php echo $this->lang->line('prescription_frequency'); ?></th>
<th style="width:15%;"><?php echo $this->lang->line('prescription_duration'); ?></th>
<th style="width:15%;"><?php echo $this->lang->line('prescription_add'); ?></th>
</tr>
</thead>
<tbody>
	<tr>
		<?php echo form_open("prescribe/add",array('id'=>'add_presc_form')); ?>
		<?php if (isset($invoice_id)): ?>
			<?php echo form_hidden('invoice_id', $invoice_id); ?>
		<?php endif ?>
		<?php echo form_hidden('item_id', $item['item_id']); ?>
		<td style="align:center;"><?php echo $item['name'];?></td>
		<td><?php echo form_input(array('name'=>'number','value'=>"",'size'=>'3')); ?></td>
		<td><?php echo form_dropdown('frequency', $frequency, "1"); ?></td>
		<td><?php echo form_input(array('name'=>'duration','value'=>"",'size'=>'3')); ?></td>
		<td><?php echo form_submit('add', $this->lang->line("prescription_add")); ?> </td>
		</form>
	</tr>

</tbody>
</table>
<br />
<?php if (isset($customer)): ?>
	<table id="register">
	<caption>Patient Prescription</caption>
	<thead>
		<th>Date</th>
		<th>Drug</th>
		<th>Dosage(ml\tablets)</th>
		<th>Frequency</th>
		<th>Duration</th>
		<th>Delete</th>
	</thead>
	<tbody id="cart_contents">
		<?php if (isset($cart)): ?>
		<?php //print_r($cart); ?>
			<?php foreach ($cart as $cart_item): ?>
			<tr>
				<td><?php echo $cart_item['time']; ?></td>
				<td><?php echo $cart_item['name'];?></td>
				<td><?php echo $cart_item['dosage'];?></td>
				<td><?php echo $cart_item['frequency']; ?></td>
				<td><?php echo $cart_item['duration']; ?></td>
				<td><?php echo anchor("prescribe/delete/".$cart_item['insertkey']."", 'Delete'); ?></td>
			</tr>
			<?php endforeach ?>
		<?php endif ?>
	</tbody>
</table>
<?php endif ?>
</div>
<div id="overall_sale">
	<?php
	if(isset($customer))
	{
		echo $this->lang->line("invoices_customer").': <b>'.$customer. '</b><br />';
		echo anchor("prescribe/remove_customer",'['.$this->lang->line('common_remove').' '.$this->lang->line('customers_customer').']');
	}
	else
	{
		echo form_open("prescribe/select_customer",array('id'=>'select_customer_form')); ?>
		<label id="customer_label" for="customer"><?php echo $this->lang->line('invoices_select_customer'); ?></label>
		<?php echo form_input(array('name'=>'customer','id'=>'customer','size'=>'30','value'=>$this->lang->line('invoices_start_typing_customer_name')));?>
		</form>
		
		<div class="clearfix">&nbsp;</div>
		<?php
	}
	?>
	<?php if (isset($customer)): ?>
	<div id='sale_details'>
		<div class="float_left" style="width:55%;">Gender:</div>
		<div class="float_left" style="width:45%;font-weight:bold;"><?php echo $gender; ?></div>
		<div class="float_left" style="width:55%;">Age:</div>
		<div class="float_left" style="width:45%;font-weight:bold;"><?php echo $age; ?></div>
		<div class="float_left" style="width:55%;">Patient_No:</div>
		<div class="float_left" style="width:45%;font-weight:bold;"><?php echo $patient_no; ?></div>
		<div class="float_left" style="width:55%;">Civil_status:</div>
		<div class="float_left" style="width:45%;font-weight:bold;"><?php echo $civil_status; ?></div>
	</div>
	<?php endif ?>
	<?php if (isset($cart)): ?>
		<div class="finish_sale">
			<?php echo form_open("prescribe/complete",array('id'=>'finish_invoice_form')); ?>
			<?php
				echo "<div class='small_button' id='finish_sale_button' style='float:left;margin-top:5px;'><span>".$this->lang->line('invoices_complete_invoice')."</span></div>";
				?>
				
			<?php echo form_close(); ?>
		</div>

	<?php endif ?>
</div>

<div class="clearfix" style="margin-bottom:30px;">&nbsp;</div>


<?php $this->load->view("partial/footer"); ?>

<script type="text/javascript" language="javascript">
$(document).ready(function()
{
    $("#item").autocomplete('<?php echo site_url("prescribe/item_search"); ?>',
    {
    	minChars:0,
    	max:100,
    	selectFirst: false,
       	delay:10,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#item").result(function(event, data, formatted)
    {
		$("#add_item_form").submit();
    });

	$('#item').focus();

	$('#item').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('invoices_start_typing_item_name'); ?>");
    });

	$('#item,#customer').click(function()
    {
    	$(this).attr('value','');
    });

    $("#customer").autocomplete('<?php echo site_url("invoices/customer_search"); ?>',
    {
    	minChars:0,
    	delay:10,
    	max:100,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#customer").result(function(event, data, formatted)
    {
		$("#select_customer_form").submit();
    });

    $('#customer').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('invoices_start_typing_customer_name'); ?>");
    });
	
	$('#comment').change(function() 
	{
		$.post('<?php echo site_url("invoices/set_comment");?>', {comment: $('#comment').val()});
	});
	
	$('#email_receipt').change(function() 
	{
		$.post('<?php echo site_url("invoices/set_email_receipt");?>', {email_receipt: $('#email_receipt').is(':checked') ? '1' : '0'});
	});
	
	
    $("#finish_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("invoices_confirm_finish_invoice"); ?>'))
    	{
    		$('#finish_invoice_form').submit();
    	}
    });

	$("#suspend_sale_button").click(function()
	{
		if (confirm('<?php echo $this->lang->line("invoices_confirm_suspend_invoice"); ?>'))
    	{
			$('#finish_invoice_form').attr('action', '<?php echo site_url("invoices/suspend"); ?>');
    		$('#finish_invoice_form').submit();
    	}
	});

    $("#cancel_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("invoices_confirm_cancel_invoice"); ?>'))
    	{
    		$('#cancel_sale_form').submit();
    	}
    });

	$("#add_payment_button").click(function()
	{
	   $('#add_payment_form').submit();
    });

	$("#payment_types").change(checkPaymentTypeGiftcard).ready(checkPaymentTypeGiftcard)
});

function post_item_form_submit(response)
{
	if(response.success)
	{
		$("#item").attr("value",response.item_id);
		$("#add_item_form").submit();
	}
}

function post_person_form_submit(response)
{
	if(response.success)
	{
		$("#customer").attr("value",response.person_id);
		$("#select_customer_form").submit();
	}
}

function checkPaymentTypeGiftcard()
{
	if ($("#payment_types").val() == "<?php echo $this->lang->line('invoices_giftcard'); ?>")
	{
		$("#amount_tendered_label").html("<?php echo $this->lang->line('invoices_giftcard_number'); ?>");
		$("#amount_tendered").val('');
		$("#amount_tendered").focus();
	}
	else
	{
		$("#amount_tendered_label").html("<?php echo $this->lang->line('invoices_amount_tendered'); ?>");		
	}
}

</script>