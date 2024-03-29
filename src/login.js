var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');
var thrash ="";

var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'admin',
	password : 'password',
	database : 'nodelogin'
});

var app = express();
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
//
// get the login page
//
app.get('/', function(request, response) {
	response.sendFile(path.join(__dirname + '/login.html'));
});
//
// perform the login check
//
app.post('/auth', function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		connection.query('SELECT * FROM accounts WHERE username = ? AND password = ?', [username, password], function(err, result) {
			if (result.length > 0) {
				request.session.loggedin = true;
				request.session.username = username;
				//
				// debug
				//
				
				Object.keys(result).forEach(function(key) {
          var row = result[key];
          //console.log(row.name)
          //response.send('output, ' + row.email + '!\n');
          thrash=row.email;         
          });

				//response.redirect('/home');
				response.redirect(request.query.redirect_url ? request.query.redirect_url : '/home');
			} else {
				//response.send('Incorrect Username and/or Password!');
				response.render('login',{error: false});
			}			
			response.end();
		});
	} else {
		response.send('Please try again.');
		//response.end();
		response.render('login',{error: false});
	}
});
 
/** Handle logout function */
app.get('/logout', (req, res) => {
  request.session.isLoggedIn = false;
  response.redirect('/');
});

//
// login ok. Main page
//
app.get('/home', function(request, response) {
	if (request.session.loggedin) {
//		response.send('Welcome back, ' + request.session.username + '!'+ thrash);
     response.sendFile(path.join(__dirname + '/home.html'));

	} else {
		response.send('Please login to view this page!');
	}
	response.end();
});

app.listen(7000);
