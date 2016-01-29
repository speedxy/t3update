<?php
ini_set("display_errors", true);
class t3updater {
	private $config;

	public function __construct(){
		$this->config = $this->read_config("config.yaml");
	}

	/**
	* 
	* Führe die Aktualisierung eines Profils durch. 
	*/
	private function update($profile){

	}

	/**
	* Lies die YAML-Konfiguratiojn ein
	*/
	private function read_config($yaml_file){
		$config = yaml_parse_file($yaml_file);
		# Ergänze Gruppen-Informationen
		foreach($config["profiles"] as &$profile){
			if($profile["status"] != "active"){
				unset($profile);
				continue;
			}
			if(!in_array($profile["group"], array_keys($config["groups"])))
				continue;
			$profile = array_merge_recursive($config["groups"][$profile["group"]], $profile);
		}
		return $config;
	}
}
