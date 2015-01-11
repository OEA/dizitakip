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
                    
                $i = 0;
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                    
                    $query->result()[$i]->series_editedtime = $this->getTimeClearly($query->result()[$i]->series_lasttime);
                    
                    $i++; 
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
    public function getRecent($_apikey, $_apisecret){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        if($query->num_rows()>0){
                
                $this->db->select('series_id,series_name,series_rating,series_img,series_lastepisode,series_lasttime');
                $this->db->where('series_active',1);
                $this->db->order_by('series_lasttime', 'asc'); 
                $query = $this->db->get('series',20,0);
                    
                $i = 0;
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                    
                    $query->result()[$i]->series_editedtime = $this->getTimeClearly($query->result()[$i]->series_lasttime);
                    
                    $i++; 
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
                    
                    $newfavorites = str_replace(' ','',$newfavorites);
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
            $this->db->order_by('series_lasttime','asc');
            $query = $this->db->get('series');
            
               
                $i = 0;
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                    
                    $query->result()[$i]->series_editedtime = $this->getTimeClearly($query->result()[$i]->series_lasttime);
                    
                    $i++; 
                }
            
            $data["result"] = $query->result();
            
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
    
    public function getFoundSeries($_apikey, $_apisecret, $_search){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        $_search = str_replace('+',' ',$_search);
        
        if($query->num_rows()>0){
                
                $this->db->select('series_id,series_name,series_rating,series_img,series_lastepisode,series_lasttime');
                $this->db->where('series_active',1);
                $this->db->like('series_name',$_search);
                $this->db->order_by('series_rating', 'desc'); 
                $query = $this->db->get('series');
                $i = 0;
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                    
                    
                    $i++; 
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
    
    public function getSeriesIdsFromGenre($name){
        $this->db->select('genre_id,genre_name');
        $this->db->like('genre_name',$name);
        $query = $this->db->get('genres');
        $seriesIds = array();
        foreach($query->result() as $result){
            $query_series = $this->db->query("SELECT * FROM series_meta WHERE series_genres REGEXP '[[:<:]]".$result->genre_id."[[:>:]]'");
            foreach($query_series->result() as $resultSeries){
                $seriesIds[] = $resultSeries->series_id;
            }
        }
        $seriesIds = array_unique($seriesIds);
        $newIdList = array();
        $newIds = "";
        foreach($seriesIds as $id){
            $newIdList[] = $id;
        }
        for($i=0;$i<count($newIdList);$i++){
            if($i==count($newIdList)-1){
                $newIds .= $newIdList[$i];
            }else{
                $newIds .= $newIdList[$i].", ";
            }
        }
        return $newIds;
    }
    public function getFoundSeriesFromGenres($_apikey, $_apisecret, $_search){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        $_search = str_replace('+',' ',$_search);
        
        if($query->num_rows()>0){
                
                $ids = explode(",",$this->getSeriesIdsFromGenre($_search));
                
                $this->db->select('series_id,series_name,series_rating,series_img,series_lastepisode,series_lasttime');
                $this->db->where('series_active',1);
                
                $this->db->where_in('series_id',$ids);
                $this->db->order_by('series_rating', 'desc'); 
                $query = $this->db->get('series');
            
                $i = 0;
                foreach($query->result() as $result){
                    $episodes = explode(":",$result->series_lastepisode);
                    $result->series_lastepisode = "S".$episodes[0]."E".$episodes[1];
                    $result->series_genres = $this->getGenres($result->series_id);   
                    
                    
                    $i++; 
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
    public function getTimeClearly($time){
		$date = strtotime(date("d M. Y"));
		
		if($date==$time){
			return "Today";
		}else if($time==strtotime("-1 day",$date)){
			return "Yesterday";
		}else if($time==strtotime("+1 day",$date)){
			return "Tomorrow";
		}else if($time==strtotime("+2 day",$date)){
			return "2 days later";
		}else if($time==strtotime("+3 day",$date)){
			return "3 days later";
		}else if($time==strtotime("+4 day",$date)){
			return "4 days later";
		}else if($time==strtotime("+5 day",$date)){
			return "5 days later";
		}else if($time==strtotime("+6 day",$date)){
			return "6 days later";
		}else if($time==strtotime("+1 week",$date)){
			return "1 week later";
		}else if($time==strtotime("+2 week",$date)){
			return "2 weeks later";
		}else{
			return date("d M. Y",$time);
		}
		
	}
    
    public function getStatistics($_apikey, $_apisecret, $_userid){
        $this->db->where('api_key',$_apikey);
        $this->db->where('api_secret',$_apisecret);
        $query = $this->db->get('api');
        
        
        if($query->num_rows()>0){
            $data["status"] = "success";
            $data["code"] = 200;
            $data["result"][0] = $this->getStatisticsFromDB($_userid);
 
        }else{
            $data["status"] = "error";
            $data["error_message"] = "You don't have any authorization to see.";
            $data["code"] = 400;
        }
        return $data;
    }
    
    public function getStatisticsFromDB($id){
		$std = new stdClass;

		$std->total_genres = $this->getCountCats();
		
		$std->total_series = $this->getCountSeries();
		
		$std->total_casts = $this->getCountCasts();
        
		$std->total_episodes = $this->getCountEpisodes();

        $stats = $this->getStatsUser($id);
        $std->liked_series = $stats->liked_series;
        
        $std->watched_episodes = $stats->watched_episodes;
        
        $std->liked_episodes = $stats->liked_episodes;
		return $std;
	}
    
    public function getCountCats(){
		$query = $this->db->get("genres");
		return "".$query->num_rows."";
	}
	public function getCountSeries(){
		$this->db->where('series_active','1');
		$query = $this->db->get("series");
		return "".$query->num_rows."";
	}
	public function getCountCasts(){
		$query = $this->db->get("casts");
		return "".$query->num_rows."";
	}
    
    public function getCountEpisodes(){
		$query = $this->db->get("episodes");
		return "".$query->num_rows."";
    }
    
    public function getStatsUser($id){
        
        $this->db->where('user_id',$id);
        $query = $this->db->get("users_meta");
        $query_object = $query->result();
        $result = $query_object[0];
        $std = new stdClass;
        
        $w_episodes = explode(",",$result->user_watchedepisodes);
        $l_episodes = explode(",",$result->user_favoritedepisodes);
        $l_series = explode(",",$result->user_favoritedseries);
        
        $std->liked_series = "".count($l_series)."";
        $std->watched_episodes = "".count($w_episodes)."";
        $std->liked_episodes = "".count($l_episodes)."";
        return $std;
    }
}




