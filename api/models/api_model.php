<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Api_Model extends CI_Model{

    private $genres = array();
	public function __construct(){
		parent::__construct();
        $query = $this->db->get('genres');
        foreach($query->result() as $result){
            $this->genres[$result->genre_id] = $result->genre_name;  
        }
	}
	
   
    public function login($_apikey, $_apisecret, $_username="", $_password=""){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
            //Username
            if($_username == "" || $_password == ""){
                    $data["status"] = "error";
                    $data["error_message"] = "Please fill all the fields";
                    $data["code"] = 400;
            }else{
                $this->db->select('user_id,user_name,user_email,user_created');
                $this->db->where('user_name',$_username);
                $this->db->where('user_password',md5($_password));

                $query = $this->db->get('users');

                if($query->num_rows()>0){
                    $data["status"] = "success";
                    $data["code"] = 200;
                    $data["result"] = $query->result();
                }else{
                    $data["status"] = "error";
                    $data["error_message"] = "Please check your credentials.";
                    $data["code"] = 400;
                }
            }
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
    
    public function register($_apikey, $_apisecret, $_username, $_password, $_email){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
            //Username
            if($_username == "" || $_password == "" || $_email == ""){
                    $data["status"] = "error";
                    $data["error_message"] = "Please fill all the fields";
                    $data["code"] = 400;
            }else{
                
                
                $this->db->where('user_name',$_username);
                $query = $this->db->get('users');
                
                if($query->num_rows()>0){
                    $data["status"] = "error";
                    $data["error_message"] = "Username is already exist. Please pick a different username.";
                    $data["code"] = 400;
                }else{
                    
                    $datainsert = array(
                        "user_name" => $_username,
                        "user_password" => md5($_password),
                        "user_email" => $_email,
                        "user_created" => date("Y-m-d H:i:s")
                    );
                    $this->db->insert('users', $datainsert); 
                    
                    
                    $this->db->select('user_id,user_name,user_email,user_created');
                    $this->db->where('user_name',$_username);
                    $this->db->where('user_password',md5($_password));

                    $query = $this->db->get('users');

                        $data["status"] = "success";
                        $data["code"] = 200;
                        $data["result"] = $query->result();
                   
                }
            }
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
    
    public function getTop10($_apikey, $_apisecret){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
                
                $this->db->select('series_id,series_name,series_rating,series_img,series_lastepisode,series_lasttime');
                $this->db->where('series_active',1);
                $this->db->order_by('series_rating', 'desc'); 
                $query = $this->db->get('series',10,0);
                    
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                }

                        $data["status"] = "success";
                        $data["code"] = 200;
                        $data["result"] = $query->result();
                   
                
               
            
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
    
    public function getGenres($series_id){
        $this->db->where('series_id',$series_id);
		$query = $this->db->get("series_meta");

		$genres_ids = $query->result()[0]->series_genres;
		$genres_ids = explode(",",$genres_ids);

		$genres = "";
		for($i=0;$i<count($genres_ids);$i++){

			$this->db->where('genre_id',$genres_ids[$i]);
			$query = $this->db->get("genres");
			foreach($query->result() as $genres_r){
                  
				    $genres .= $genres_r->genre_name.", ";
			}
		}
        $genres = substr($genres, 0, -2);
		return $genres;
    }
    
    public function likeSeries($_apikey, $_apisecret, $_seriesId, $_userId){
        
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
            $this->db->where('user_id',$_userId);
            $query = $this->db->get("users_meta");
            $query_object = $query->result()[0];
            $newfavorites = "";
            $isDeleted = false;
            if($query->num_rows>0){
                //update
                $query_object = $query->result()[0];
                if($query_object->user_favoritedseries==""){
                        $data["status"] = "success";
                        $data["code"] = 200;
                        $data["message"] = "Liked";
                    
                    $datas = array(
                            'user_favoritedseries' => $_seriesId,
                    );
                    $this->db->where('user_id', $_userId);
                    $this->db->update('users_meta', $datas); 
                }else{
                    $favorites = explode(",",$query_object->user_favoritedseries);
                    if(in_array($_seriesId, $favorites)){
                        $isDeleted = true;
                        $data["status"] = "error";
                        $data["code"] = 200;
                        $data["message"] = "Unliked";
                    }
                    if(!$isDeleted){
                        $newfavorites = $query_object->user_favoritedseries.", ".$_seriesId;
                        $data["status"] = "success";
                        $data["code"] = 200;
                        $data["message"] = "Liked";
                    }else{
                        
                        for($i=0;$i<count($favorites);$i++){
                            if(!($_seriesId==$favorites[$i])){
                                if($i==0){
                                    $newfavorites .= $favorites[$i];  
                                }else{
                                    $newfavorites .= ", ".$favorites[$i];  
                                } 
                            }
                        }
                    }
                    

                    $datas = array(
                            'user_favoritedseries' => $newfavorites,
                    );
                    $this->db->where('user_id', $_userId);
                    $this->db->update('users_meta', $datas); 
                   
                }
               
            }else{
                $data["status"] = "success";
                $data["code"] = 200;
                $data["message"] = "Liked";
                //insert
                
                    $datas = array(
                        'user_id' => $_userId,
                        'user_favoritedseries' => $_seriesId,
                    );	
                $this->db->insert('users_meta', $datas); 
            }
            
           
            
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
        
    }
    
    public function isLikedSeries($_apikey, $_apisecret, $_seriesId, $_userId){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
            $this->db->where('user_id',$_userId);
            $query = $this->db->get("users_meta");
            $query_object = $query->result()[0];
            $favorited_series = $query_object->user_favoritedseries;
            $array_ids = explode(",", $favorited_series);
           
            
            if(in_array($_seriesId, $array_ids)){
                $data["status"] = "success";
                $data["message"] = "isLiked";
                $data["code"] = 200;
            }else{
                $data["status"] = "error";
                $data["message"] = "isNotLiked";
                $data["code"] = 200;
            }
           
            
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
        
    }
    
    public function getLikedSeries($_apikey, $_apisecret, $_userId){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
            
            $this->db->where('user_id',$_userId);
            $query = $this->db->get("users_meta");
            $query_object = $query->result()[0];
            $favorited_series = $query_object->user_favoritedseries;
            $series = explode(",",$favorited_series);
            
            $data["status"] = "success";
            $data["code"] = 200;
            
            $this->db->select('series_id,series_name,series_rating,series_img,series_lastepisode,series_lasttime');
            $this->db->where('series_active',1);
            $this->db->where_in('series_id',$series);
            $query = $this->db->get('series');
            $data["result"] = $query->result();
            
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
}




