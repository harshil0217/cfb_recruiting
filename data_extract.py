import cfbd
from cfbd.rest import ApiException
from pprint import pprint
import pandas as pd


#configure API key
configuration = cfbd.Configuration()
configuration.api_key['Authorization'] = 'V0gKQ2NsBKqVWwtw+rG4Xwb+RymmYZavnzylQCaDllBrinJFAeVFZCyHAxk0a8px'
configuration.api_key_prefix['Authorization'] = 'Bearer'

#create instance of recruiting API
recruiting_api = cfbd.RecruitingApi(cfbd.ApiClient(configuration))
year = 56

try:
    # Betting lines
    api_response = recruiting_api.get_recruiting_teams(year=2023)
    api_response = [obj.to_dict() for obj in api_response]
    pprint(api_response)
except ApiException as e:
    print("did not work")

#convert api response to pandas dataframe
rankings = pd.DataFrame(api_response)
rankings.rename(columns={"team":"Team"}, inplace=True)
rankings.to_csv('recruiting_rankings.csv', index=False)


