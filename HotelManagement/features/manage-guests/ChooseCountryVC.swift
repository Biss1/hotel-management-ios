
import UIKit

protocol CountryChooserDelegate: class {
    func choosedCountry (country: Country)
}

class ChooseCountryVC: UITableViewController, UISearchResultsUpdating {
    
    var selectedcountry: Country?
    weak var countrychoserDelegate: CountryChooserDelegate?
    var filteredcountries = [Country] ()
    var searchController = UISearchController()
    let colors = Colors()
    let dataService = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = colors.primarycolor
        updateSearchResults(for: searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredcountries = dataService.countries.filter ({ (country: Country) -> Bool in
                 country.name.containsStringIgnoreCase(strTest: searchText)
            })
        } else {
            filteredcountries = dataService.countries
        }
        tableView.reloadData()
    }
}

extension ChooseCountryVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedcountry = filteredcountries[indexPath.row]
        countrychoserDelegate?.choosedCountry(country: selectedcountry!)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredcountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countrycell") as! CountriesCell
        let country = filteredcountries[indexPath.row]
        cell.initWith(country: country)
        return cell
    }
}
    
    
    




