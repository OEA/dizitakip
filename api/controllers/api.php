<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Api extends CI_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->model('api_model','api');
    }
    
    public function login(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_username = $this->input->get('username',TRUE);
        $_password = $this->input->get('password',TRUE);
        
        $data = $this->api->login($_apikey, $_apisecret, $_username, $_password);
        echo json_encode($data);
    }
    
    public function register(){
     
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_username = $this->input->get('username',TRUE);
        $_email = $this->input->get('email',TRUE);
        $_password = $this->input->get('password',TRUE);
        
        $data = $this->api->register($_apikey, $_apisecret, $_username, $_password, $_email);
        echo json_encode($data);   
    }
}
