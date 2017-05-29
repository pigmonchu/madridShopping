import CoreData

extension ShopsViewController: NSFetchedResultsControllerDelegate {

    var fetchedResultsController: NSFetchedResultsController<Shop> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: Shop.fetchRequestOrderedById(),
                                                               managedObjectContext: self.context!,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil) // Recuerda que si cambiara asociarías un caché a cada fetchRequest que quieras guardarte paluego
        
        _fetchedResultsController?.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            
        }
        
        return _fetchedResultsController!
    }

}
