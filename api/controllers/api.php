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
    
    public function getTop10(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        
        $data = $this->api->getTop10($_apikey, $_apisecret);
        echo json_encode($data);   
    }
    
    public function getrecent(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        
        $data = $this->api->getRecent($_apikey, $_apisecret);
        echo json_encode($data);   
    }
    
    public function likeSeries(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_seriesId = $this->input->get('seriesId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->likeSeries($_apikey, $_apisecret, $_seriesId, $_userId);
        echo json_encode($data);   
    }
    
    public function isLikedSeries(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_seriesId = $this->input->get('seriesId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->isLikedSeries($_apikey, $_apisecret, $_seriesId, $_userId);
        echo json_encode($data);   
    }
    
    public function likeEpisode(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_episodeId = $this->input->get('episodeId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->likeEpisode($_apikey, $_apisecret, $_episodeId, $_userId);
        echo json_encode($data);   
    }
    
    public function isLikedEpisode(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_epsiodeId = $this->input->get('episodeId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->isLikedEpisode($_apikey, $_apisecret, $_epsiodeId, $_userId);
        echo json_encode($data);  
    }
    public function watchEpisode(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_episodeId = $this->input->get('episodeId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->watchEpisode($_apikey, $_apisecret, $_episodeId, $_userId);
        echo json_encode($data);   
    }
    
    public function isWatchedEpisode(){
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_epsiodeId = $this->input->get('episodeId',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->isWatchedEpisode($_apikey, $_apisecret, $_epsiodeId, $_userId);
        echo json_encode($data);  
    }
    
    public function likedseries(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_userId = $this->input->get('userId',TRUE);
        
        $data = $this->api->getLikedSeries($_apikey, $_apisecret, $_userId);
        echo json_encode($data);   
    }
    
    public function search(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_search = $this->input->get('search',TRUE);
        
        $data = $this->api->getFoundSeries($_apikey, $_apisecret, $_search);
        
        echo json_encode($data);   
        
       
    }
    
    public function searchgenres(){
             
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_search = $this->input->get('search',TRUE);
        
        $data = $this->api->getFoundSeriesFromGenres($_apikey, $_apisecret, $_search);
        echo json_encode($data);   
        
       
    }
    
    public function getstatistics(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_userId = $this->input->get('userId',TRUE);
    
        $data = $this->api->getStatistics($_apikey, $_apisecret, $_userId);
        echo json_encode($data);   
    }
    
    public function getseasons(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_seriesId = $this->input->get('seriesId',TRUE);
    
        $data = $this->api->getSeasons($_apikey, $_apisecret, $_seriesId);
        echo json_encode($data);  
    }
    
    public function getcasts(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_seriesId = $this->input->get('seriesId',TRUE);
    
        $data = $this->api->getCasts($_apikey, $_apisecret, $_seriesId);
        echo json_encode($data);  
    }
    
    public function getepisodes(){
        
        $_apikey = $this->input->get('apiKey',TRUE);
        $_apisecret = $this->input->get('apiSecret',TRUE);
        $_seriesId = $this->input->get('seriesId',TRUE);
        $_season = $this->input->get('season',TRUE);
    
        $data = $this->api->getEpisodes($_apikey, $_apisecret, $_seriesId, $_season);
        echo json_encode($data);  
    }
}
