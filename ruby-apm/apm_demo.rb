#!/usr/bin/env ruby

#-------------------------------------------------------------------------------------------------
# The apm_demo of the Ruby binding
#                                                              Copyright (C) 2011 Antiy Labs
# This file is part of free software: you can redistribute it and/or modify it under the 
# terms of the GNU General Public License as published by the Free Software Foundation, 
# either version 3 of the License, or any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.
# Antiy Password Mixer was written by Antiy Labs.  You can contact the author
# by e-mail to `apm@antiy.com' 
#-------------------------------------------------------------------------------------------------

require 'apm'

def apm_demo_register_user_test(user, password, ext_info)
	ret = apm_register_user(user, password, ext_info)
	if ret == 0
		puts "apm_demo_register_user_test: regisetr user successful!"
	end
	
	if ret == -1
		puts "apm_demo_register_user_test: cann't open database %s"%(g_apm_db_name)
	end
	
	if ret == -2
        	puts "apm_demo_register_user_test: user or password is NULL"
        end
        
	if ret == -3
		puts "apm_demo_register_user_test: user [%s] already reigster"%(user)
	end
	
	if ret == -4
		puts "apm_demo_register_user_test: save original password error!"
	end
	
	if ret == -5
		puts "apm_demo_register_user_test: save extend information error!"
	end
	
	if ret == -6
		puts "apm_demo_register_user_test: save user information error!"
	end
	
	if ret == -7
		puts "apm_demo_register_user_test: it's a frequently used password!"
	end
end

def apm_demo_change_pwd_test(user, oldpwd, newpassword)
	ret = apm_change_pwd(user, oldpwd, newpassword)
	if ret == 0
		puts "apm_demo_change_pwd_test: change password successful !"
	end
	
	if ret == -1
		puts "apm_demo_change_pwd_test: cann't open database %s"%(g_apm_db_name)
	end
	
	if ret == -2
		puts "apm_demo_change_pwd_test: user or password is NULL"
	end
	
	if ret == -3
		puts "apm_demo_change_pwd_test: user name doesn't exist or password is incorrect"
	end
	
	if ret == -4
		puts "apm_demo_change_pwd_test: user name is invalid"
	end
	
	if ret == -5
		puts "apm_demo_change_pwd_test: save user information error!"
	end
end

def apm_demo_authenticate_user_test(user, password)
	ret = apm_authenticate_user(user, password)
	if ret == 0
		puts "apm_demo_authenticate_user_test: authenticate password successful !"
	end
	
	if ret == -1
		puts "apm_demo_authenticate_user_test: cann't open database %s"%(g_apm_db_name)
	end
	
	if ret == -2
		puts "apm_demo_authenticate_user_test: user or password is NULL"
	end
	
	if ret == -3
		puts "apm_demo_authenticate_user_test: user name doesn't exist"
	end
	
	if ret == -4
		puts "apm_demo_authenticate_user_test: user name is invalid"
	end
	
	if ret == -5
		puts "apm_demo_authenticate_user_test: authenticate password error!"
	end
end

def apm_demo_delete_user_test(user)
	ret = apm_delete_user(user)
	if ret == 0
		puts "apm_demo_delete_user_test: delete user successful !"
	end
	
	if ret == -1
		puts "apm_demo_delete_user_test: cann't open database %s"%(g_apm_db_name)
	end
	
	if ret == -2
		puts "apm_demo_delete_user_test: user name is NULL"
	end
	
	if ret == -3
		puts "apm_demo_delete_user_test: user name is invalid"
	end
end

# test register user
apm_demo_register_user_test("testuser", "passwordtest", "")

# test register user and alreadly register
apm_demo_register_user_test("testuser", "passwordtest", "")

# test register user and it's a frequently used password, g_apm_check_frequently_used_pwd must set 1
apm_demo_register_user_test("testuser1", "iloveyou", "")
apm_demo_register_user_test("testuser1", "19820502", "")
apm_demo_register_user_test("testuser1", "atestuser1", "")

# test change password
apm_demo_change_pwd_test("testuser", "passwordtest", "passwordtest1")

# test change password and password is NULL
apm_demo_change_pwd_test("testuser", "", "passwordtest1")

# test change password and user name doesn't exist
apm_demo_change_pwd_test("testuser123", "passwordtest", "passwordtest1")

# test change password and input password is invalid
apm_demo_change_pwd_test("testuser", "passwordtest", "passwordtest1")

# test authenticate user
apm_demo_authenticate_user_test("testuser", "passwordtest1")

# test authenticate user and password is NULL
apm_demo_authenticate_user_test("testuser", "")

# test authenticate user and user name doesn't exist
apm_demo_authenticate_user_test("testuser123", "passwordtest1")

# test authenticate user and password is invalid
apm_demo_authenticate_user_test("testuser", "passwordtest")

# test delete user
apm_demo_delete_user_test("testuser")

# test delete user and username is NULL
apm_demo_delete_user_test("")

# test delete user and username is invalid
apm_demo_delete_user_test("testuser")