<?php

	// FogBugz notifier version 0.1
	// @author: Bob Brown, gurubob@gmail.com
	// @date: 2009-12-09
	/*
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
	*/

	// Adjust these defines to suit your installation
	define( 'FBBASEURL', 'https://samsix.fogbugz.com/' );
	define( 'FBUSERNAME', 'thomas.corbin@gmail.com' );
	define( 'FBPASSWORD', 'ihatent1' );

	// No need to change anything below here, unless you want to
	define( 'FBIGNOREVERSION', false );
	define( 'FB_ICON', dirname(__FILE__).'/fogbugz.png' );
	define( 'FB_ALERT_ICON', dirname(__FILE__).'/fogbugz-alert.png' );
	
	// FogBugz Helper Class
	class FogBugz
	{
		protected $_token;
		protected $_url;
		
		function login($email,$password)
		{
			$result = $this->call('logon',array('email'=>$email,'password'=>$password));
			if ($result->token)
			{
				$this->_token = (string)$result->token;
				return true;
			}
			throw new Exception($result->error.'. Check your credentials.');
		}
		
		function logout()
		{
			return $this->call('logout');
		}
		
		function call($cmd,$params=array())
		{
			$url = $this->_url.'cmd='.$cmd.'&';
			if ($this->_token)
			{
				$url .= 'token='.$this->_token;
			}
			
			if (!empty($params))
			{
				foreach ($params as $key=>$value)
				{
					$url .= '&'.$key.'='.$value;
				}
			}
			return simplexml_load_string(file_get_contents($url));
		}
		
		function notify($notifyIcon, $notifyTitle, $notifyBody)
		{
			$cmd = '/usr/bin/notify-send -i '.$notifyIcon.' "'.$notifyTitle.'" "'.$notifyBody.'"';
			system($cmd);
		}
		
		function __construct($fbUrl)
		{
			$this->_url = $fbUrl;
			$api = simplexml_load_string(file_get_contents($fbUrl.'api.xml'));
			$this->_url = $fbUrl.(string)$api->url;
			
			if ($api->version < 7 && !FBIGNOREVERSION)
			{
				throw new Exception('This script is not designed to work with FogBugz version '.(string)$api->version.'.  If you want to ignore this and continue please set the FBIGNOREVERSION constant to true');
			}
		}
	}


	// Main Routine
	$fb = new FogBugz( FBBASEURL );
	try
	{
		$fb->login( FBUSERNAME, FBPASSWORD );
	
		// Get a list of projects worked on today
		$currentProjects = $fb->call('listIntervals',array('dtStart'=>gmdate('Y-m-d\T\0\0:\0\0:\0\0\Z'),'dtEnd'=>gmdate('Y-m-d\T\2\3:\5\9:\5\9\Z')));
		
		// Now look for a project that has an empty dtEnd value (this, if present, is the project currently being worked on)
		$currentProject = $currentProjects->xpath('//dtEnd[not(string(.))]/..');
		
		// If we find one ..
		if ($currentProject !== false)
		{
			$project = $currentProject[0];
			
			// Get the details of the case (any "q" command returns an array of cases, even if it's just one)
			$cases = $fb->call('search',array('q'=>$project->ixBug,'cols'=>'hrsCurrEst,hrsElapsed,ixBug,sTitle'));
			
			$caseTitle = (string)$cases->cases->case->sTitle;
			$caseNumber = (string)$cases->cases->case->ixBug;
			$caseEstimate = (string)$cases->cases->case->hrsCurrEst;
			$caseElapsed = (string)$cases->cases->case->hrsElapsed;
			$timeRemaining = $caseEstimate - $caseElapsed;
		
			// And finally call notify-send to display the details of it
			$notifyTitle = 'Active Case: #'.$caseNumber.' '.$caseTitle;
			if ($timeRemaining >= 0)
			{
				$notifyBody = 'Estimated time: '.number_format($caseEstimate,1).'hrs, remaining: '.number_format($timeRemaining,1).'hrs';
				$notifyIcon = FB_ICON;
			}
			else
			{
				$notifyBody = 'Estimated time: '.number_format($caseEstimate,1).'hrs, time spent: '.number_format($caseElapsed,1).'hrs.  You are '.abs(number_format($timeRemaining,2)).' hours over estimate.';
				$notifyIcon = FB_ALERT_ICON;
			}			
	
			$fb->notify($notifyIcon, $notifyTitle, $notifyBody);
		}
	}
	catch (Exception $e)
	{
		$fb->notify(FB_ALERT_ICON, 'FogBugz Error', $e->getMessage());
	}
	
	// We're done here, log out.
	$fb->logout();
	
