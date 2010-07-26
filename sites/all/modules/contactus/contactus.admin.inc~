<?php
// $Id

/**
 * @file
 * File with admin functions for Contactus module
 */
 
 /**
  * Menu callback and form builder for admin/settings/contactus
  */
  
  function contactus_admin_settings($form_state) {
	$form = array();
	$form['id'] = array(
		'#type' => 'textfield' ,
		'#title' => t('Emailid of recipient in contactus page'),
		'#description' => t('Enter the emailid of the recipient on the contactus page'),
		'#default_value' => variable_get('id', t('Emailid')),
		'#required' => TRUE,
	);
	$form['lane'] = array(
		'#type' => 'textfield' ,
		'#title' => t('Name of the Organization and locality'),
		'#description' => t('Enter the name of the organization and its locality'),
		'#default_value' => variable_get('lane', t('Organization Name and Locality')),
		'#required' => TRUE,
	);
	$form['area'] = array(
		'#type' => 'textfield' ,
		'#title' => t('Area'),
		'#description' => t('Enter the area name of the organization'),
		'#default_value' => variable_get('area', t('Area of organization')),
		'#required' => TRUE,
	);
	$form['city'] = array(
		'#type' => 'textfield',
		'#title' => t('City and Pincode'),
		'#description' => t('Enter the city name and the pincode of your area'),
		'#default_value' => variable_get('city', t('City and Pincode')),
		'#required' => TRUE,
	);
	$form['telno'] = array(
		'#type' => 'textfield',
		'#title' => t('Telephone Number'),
		'#description' => t('Enter a contact number for the organization'),
		'#default_value' => variable_get('telno', t('Telephone Number')),
		'#required' => TRUE,
	);
	$form['#submit'][] = 'contactus_admin_settings_submit';
	return system_settings_form($form);

}

/** 
 * Storing the contact information in the database
 */
 
 function contactus_admin_settings_submit($form, &$form_state) {
	variable_set('id' ,$form_state['values']['id']);
	variable_set('lane' ,$form_state['values']['lane']);
	variable_set('area' ,$form_state['values']['area']);
	variable_set('city' ,$form_state['values']['city']);
	variable_set('telno' ,$form_state['values']['telno']);
	$email_id = $form_state['values']['id'];
	$lane = $form_state['values']['lane'];
	$area = $form_state['values']['area'];
	$city = $form_state['values']['city'];
	$telno = $form_state['values']['telno'];
	$query = "DELETE FROM {contactus} ";
	$result = db_query($query);
	$query = "INSERT INTO {contactus} (id,lane,area,city,telno) VALUES ('%s','%s','%s','%s','%s')" ;
	$result =db_query($query, $email_id,$lane,$area,$city,$telno);
	
}
