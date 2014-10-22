import Quick
import Nimble
import UIKit

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController:MainViewController!
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass:self.dynamicType))
            let navController:UINavigationController = storyboard.instantiateInitialViewController() as UINavigationController
            viewController = navController.topViewController as? MainViewController
        }
        
        describe("Initialization") {
            it("Is not nil") {
                expect(viewController).toNot(beNil())
            }
        }
        
        describe("Navigation Bar") {
            it("Has a title") {
                
            }
        }
    }
}
