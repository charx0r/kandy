<?php

/**
 * Implementation of hook_node_info().
 */
function video_gallery_node_info() {
  $items = array(
    'video' => array(
      'name' => t('Video'),
      'module' => 'features',
      'description' => t('This will create a video for the video gallery in the website. Enter the url ex:youtube,blip.tv,etc. that should be embedded into the gallery.'),
      'has_title' => '1',
      'title_label' => t('Video title'),
      'has_body' => '0',
      'body_label' => '',
      'min_word_count' => '0',
      'help' => '',
    ),
  );
  return $items;
}

/**
 * Implementation of hook_views_api().
 */
function video_gallery_views_api() {
  return array(
    'api' => '2',
  );
}
