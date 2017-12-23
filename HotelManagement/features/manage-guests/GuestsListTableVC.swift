
import UIKit

class GuestsListTableVC: UITableViewController, ManageGuestDelegate {

    var selectedGuest: Guest?
    let dataService = DataService()
    func saveGuest(guest: Guest) {
        dataService.updateGuest(guest: guest)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "guestListToDetailsSegue") {
            let navigationController = segue.destination as! UINavigationController
            let manageController = navigationController.viewControllers[0] as! ManageGuestTableVC
            manageController.guest = selectedGuest
            manageController.manageGuestDelegate = self
        }
    }
}

extension GuestsListTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.numberOfGuestsinList()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCell") as! GuestsCell
        let guest = dataService.guests[indexPath.row]
        cell.fillWith(guest: guest)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dataService.guests.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGuest = dataService.guests[indexPath.row]
        performSegue(withIdentifier: "guestListToDetailsSegue", sender: self)
    }
    
}



