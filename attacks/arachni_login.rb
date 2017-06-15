hostname = 'http://192.168.250.9:8080'

login_url = hostname + '/login'

=begin
browser.goto login_url

browser.text_field( name: 'username' ).set 'llclradmin@nonexistanttest.com'
browser.text_field( name:'password' ).set 'password'
browser.button( id:'btnSubmit' ).click

framework.options.session.check_url = browser.url
framework.options.session.check_pattern = /Sign out/
=end

#=begin
response = http.post( login_url,
                      parameters:     {
                          'username'   => 'llclradmin@nonexistanttest.com',
                          'password' => 'password'
                      },
                      mode:           :sync,
                      update_cookies: true,
                      content_type: 'application/x-www-form-urlencoded'
)
framework.options.session.check_url = to_absolute( response.headers.location, response.url ) #'http://192.168.250.9:8080/login'
framework.options.session.check_pattern = '/.*'
#=end

# Set up maintain-frontend add charge session
body = { add_charge_state: { 'statutory-provision' => 'Building Act 1984 section 107',
                             'geometry' => { features: [{ geometry: { coordinates: [294793, 9353], type: 'Point' },
                                                          properties: { id: 437 }, crs: { properties: { name: 'urn:ogc:def:crs:EPSG::27700' },
                                                                                          type: 'name' }, type: 'Feature' }],
                                             type: 'FeatureCollection' },
                             'charge-geographic-description' => 'abc',
                             'instrument' => 'notice',
                             'charge-type' => 'a type',
                             'originating-authority' => 'an authority',
                             'further_information_location' => 'abc' } }

url = hostname + ':8001/v1.0/sessions'

session_key = http.post(url, 'testuser')

#url += '/' + session_key + '/state/maintain_frontend'
#session_response = RestClient.put(url, body.to_json, content_type: 'json')

=begin
# These snippets are used in the acceptance tests for the add flow, expiry page

body = { add_charge_state: { 'statutory-provision' => 'Building Act 1984 section 107',
                             'geometry' => { features: [{ geometry: { coordinates: [294793, 9353], type: 'Point' },
                                                          properties: { id: 437 }, crs: { properties: { name: 'urn:ogc:def:crs:EPSG::27700' },
                                                                                          type: 'name' }, type: 'Feature' }],
                                             type: 'FeatureCollection' },
                             'charge-geographic-description' => 'abc',
                             'instrument' => 'notice',
                             'charge-type' => 'a type',
                             'originating-authority' => 'an authority',
                             'further_information_location' => 'abc' } }

url = Env.session

session_key = RestClient.post(url, 'testuser') { |response| response }

url += '/' + session_key + '/state/maintain_frontend'

session_response = RestClient.put(url, body.to_json, content_type: 'json') { |response| response }

=end
