<?php
/**
 * @file kandy.profile
 */

/**
 * Implementation of hook_profile_details()
 */
function kandy_profile_details() {  
  return array(
    'name' => 'Kandy',
    'description' => st('Kandy Distribution from Jybe Tech Solutions'),
  );
} 

/**
 * Implementation of hook_profile_modules().
 */
function kandy_profile_modules() {
  $core_modules = array(
    // Required core modules
    'block', 'filter', 'node', 'system', 'user',

    // Optional core modules.
    'blog', 'comment', 'help', 'locale', 'menu', 'openid', 'path',
	  'profile', 'search', 'statistics', 'taxonomy', 'translation', 'upload', 'poll', 'contact', 'forum', 'aggregator', 'color',
  );

  $contributed_modules = array(
    //admin modules
    'admin',

    //development modules
    'devel',

    //Install profile
    'install_profile_api',

    //cck
    'content', 'content_copy', 'fieldgroup', 'number',
    'optionwidgets', 'text', 'nodereference', 'userreference',

    //views
    'views', 'views_export', 'views_ui', 

    //misc modules
    'advanced_help', 'pathauto',
      );

  return array_merge($core_modules, $contributed_modules);
} 

/**
 * Return a list of tasks that this profile supports.
 *
 * @return
 *   A keyed array of tasks the profile will perform during
 *   the final stage. The keys of the array will be used internally,
 *   while the values will be displayed to the user in the installer
 *   task list.
 */
function kandy_profile_task_list() {
  global $conf;
  $conf['site_name'] = 'Kandy';
  $conf['site_footer'] = 'Kandy by <a href="http://www.jybetech.com">Jybe Tech Solutions</a>';
  $conf['theme_settings'] = array(
    'default_logo' => 0,
    'logo_path' => 'sites/all/themes/deco/images/logo.jpg',
  );
  
  $tasks['kandy-configure-batch'] = st('Configure Kandy');
  return $tasks;
}

/**
 * Implementation of hook_profile_tasks().
 */
function kandy_profile_tasks(&$task, $url) {
  $output = "";
  install_include(kandy_profile_modules());

  if($task == 'profile') {
    drupal_set_title(t('Kandy Installation'));
    _kandy_log(t('Starting Installation'));
    _kandy_base_settings();
    $task = "kandy-configure";
  }
    
  if($task == 'kandy-configure') {
    $batch['title'] = st('Configuring @drupal', array('@drupal' => drupal_install_profile_name()));
    $files = module_rebuild_cache();            
    $batch['operations'][] = array('_kandy_cleanup', array());      
    $batch['error_message'] = st('There was an error configuring @drupal.', array('@drupal' => drupal_install_profile_name()));
    $batch['finished'] = '_kandy_configure_finished';
    variable_set('install_task', 'kandy-configure-batch');
    batch_set($batch);
    batch_process($url, $url);
  }
     
  // Land here until the batches are done
  if ($task == 'kandy-configure-batch') {
    include_once 'includes/batch.inc';
    $output = _batch_page();
  }
    
  return $output;
} 


/**
 * Create some content of type "page" as placeholders for content
 * and so menu items can be created
 */
/*function _kandy_placeholder_content(&$context) {
  global $base_url;  

  $user = user_load(array('uid' => 1));
 
  $page = array (
    'type' => 'page',
    'language' => 'en',
    'uid' => 1,
    'status' => 1,
    'comment' => 0,
    'promote' => 0,
    'moderate' => 0,
    'sticky' => 0,
    'tnid' => 0,
    'translate' => 0,    
    'revision_uid' => 1,
    'title' => st('Default'),
    'body' => 'Placeholder',    
    'format' => 2,
    'name' => $user->name,
  );
  
  $start = (object) $page;
  $start->title = st('Getting Started');
  $start->body = '<h1>Welcome to your new Kandy Site.</h1>Initially your site does not have any content, and that is where the fun begins. Use the thin black administration menu across the top of the page to accomplish many of the tasks needed to get your site up and running in no time.<br/><br/><h3>To create content</h3>Select <em>Content</em> -> <em>Add</em> from the administration menu (remember that little black bar at the top of the page?) to get started.  You can create a variety of content, but to start out you may want to create a few simple <a href="'. $base_url . '/node/add/article">Articles</a> or import items from an <a href="'. $base_url . '/node/add/feed">RSS Feed</a><h3>To change configuration options</h3>Select <em>Configuration</em> from the administration menu to change various configuration options and settings on your site.<h3>To add other users</h3>Select <em>People</em> -> <em>Users</em> from the administration menu to add new users or change user roles and permissions (please note tabs on the far right).<h3>Need more help?</h3>Select <em>Help</em> from the administration menu to learn more about what you can do with your site.<br/><br/>Don\'t forget to look for more resources and documentation at the <a href="http://www.jybetech.com">Jybe Tech Solutions</a> website.<br/><br/>ENJOY!!!!';  
  node_save($start);

  menu_rebuild();
  
  $context['message'] = st('Installed Content');
}*/

/**
 * Import process is finished, move on to the next step
 */
function _kandy_configure_finished($success, $results) {
  _kandy_log(t('Kandy has been installed.'));
  variable_set('install_task', 'profile-finished');
}

/**
 * Do some basic setup
 */
function _kandy_base_settings() {  
  global $base_url;  
 
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Page'),
      'module' => 'node',
      'description' => st("A <em>page</em>, not similar in form to a <em>story</em>, is a simple method for creating and displaying information that rarely changes, such as an \"About us\" section of a website. By default, a <em>page</em> entry does not allow visitor comments and is not featured on the site's initial home page."),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
      'help' => '',
      'min_word_count' => '',
    ),   
  );

  foreach ($types as $type) {
    $type = (object) _node_type_set_defaults($type);
    node_type_save($type);
  }

  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));
  variable_set('comment_page', COMMENT_NODE_DISABLED);

  // Theme related.  
  install_default_theme('deco');
  install_admin_theme('rubik');	
  variable_set('node_admin_theme', TRUE);    
  
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['toggle_node_info_page'] = FALSE;
  $theme_settings['default_logo'] = FALSE;
  $theme_settings['logo_path'] = 'sites/all/themes/deco/images/logo.jpg';
  variable_set('theme_settings', $theme_settings);    
  
  // Basic Drupal settings.
  variable_set('site_frontpage', 'node');
  variable_set('user_register', 1); 
  variable_set('user_pictures', '1');
  variable_set('statistics_count_content_views', 1);
  variable_set('filter_default_format', '1');
  
  // Set the default timezone name from the offset
  $offset = variable_get('date_default_timezone', '');
  $tzname = timezone_name_from_abbr("", $offset, 0);
  variable_set('date_default_timezone_name', $tzname);
  
  _kandy_log(st('Configured basic settings'));
}

/**
 * Cleanup after the install
 */
function _kandy_cleanup() {
  // DO NOT call drupal_flush_all_caches(), it disables all themes
  $functions = array(
    'drupal_rebuild_theme_registry',
    'menu_rebuild',
    'install_init_blocks',
    'node_types_rebuild',    
  );
  
  foreach ($functions as $func) {
    //$start = time();
    $func();
    //$elapsed = time() - $start;
    //error_log("####  $func took $elapsed seconds ###");
  }
   
  cache_clear_all('*', 'cache', TRUE);  
  cache_clear_all('*', 'cache_content', TRUE);
}

/**
 * Set Kandy as the default install profile
 */
function system_form_install_select_profile_form_alter(&$form, $form_state) {
  foreach($form['profile'] as $key => $element) {
    $form['profile'][$key]['#value'] = 'kandy';
  }
}


/**
 * Consolidate logging.
 */
function _kandy_log($msg) {
  error_log($msg);
  drupal_set_message($msg);
}
