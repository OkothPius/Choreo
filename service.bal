import ballerinax/worldbank;
import ballerina/http;

service /country on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get info/[string country]() returns json|error {
        // Send a response back to the caller.

        worldbank:Client worldbankEndpoint = check new ({});
        worldbank:IndicatorInformation[] populationByCountry = check worldbankEndpoint->getPopulationByCountry(country);
        float populationInMillions = <float>(populationByCountry[0]?.value ?: 0) / 1000000;
        worldbank:IndicatorInformation[] gdpByCountry = check worldbankEndpoint->getGDPByCountry(country);
        float countryGDP = <float>(gdpByCountry[0]?.value ?: 0);

        json countryInfo = {country: country, populationInMillions: populationInMillions, GDP: countryGDP};
        return countryInfo;
    }
}
