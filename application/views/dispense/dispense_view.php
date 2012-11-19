<?php $this->load->view("partial/header"); ?>
<div id="page_title" style="margin-bottom:8px;"><?php echo $this->lang->line('Dispense_Module'); ?></div>
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
	<table id='register'>
	<caption>Patient Prescription</caption>
	<thead>
		<tr>
			<th style="width:10%;"><?php echo $this->lang->line('dispense_date'); ?></th>
			<th style="width:10%;"><?php echo $this->lang->line('dispense_drug'); ?></th>
			<th style="width:15%;"><?php echo $this->lang->line('dispense_dosage'); ?></th>
			<th style="width:15%;"><?php echo $this->lang->line('dispense_frequency'); ?></th>
			<th style="width:15%;"><?php echo $this->lang->line('dispense_duration'); ?></th>
		</tr>
	</thead>
<?php if (isset($customer)): ?>
	<tbody id="cart_contents">
		<?php foreach ($histories as $history): ?>
		<tr>
			<td><?php echo $history->invoice_time; ?></td>
			<td><?php echo $history->name; ?></td>
			<td><?php echo $history->dosage; ?></td>
			<td><?php echo $history->frequency; ?></td>
			<td><?php echo $history->duration; ?></td>
		</tr>
		<?php endforeach ?>
	</tbody>
<?php endif ?>
</table>

</div>
<div id="overall_sale">
	<?php
	if(isset($customer))
	{
		echo $this->lang->line("invoices_customer").': <b>'.$customer. '</b><br />';
		echo anchor("dispense/remove_customer",'['.$this->lang->line('common_remove').' '.$this->lang->line('customers_customer').']');
	}
	else
	{
		echo form_open("dispense/select_customer",array('id'=>'select_customer_form')); ?>
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
</div>
<div class="clearfix" style="margin-bottom:30px;">&nbsp;</div>


<?php $this->load->view("partial/footer"); ?>

<script type="text/javascript" language="javascript">
$(document).ready(function()
{
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