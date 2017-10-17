// https://github.com/Quick/Quick

import Quick
import Nimble
import TaCoPopulator


class SectionDataProviderSpec : QuickSpec {
    override func spec() {
        describe("SectionDataProvider will provide the elements for one section") {
            
            
            context("Int"){
                var sut: SectionDataProvider<Int>?
                
                beforeEach {
                    sut = SectionDataProvider<Int> {
                        _,_  in
                        return "cell"
                    }
                    sut?.provideElements(Array(0 ..< 7))
                }
                
                it("counts 7 elements"){
                    expect(sut?.elements().count).to(equal(7))
                    expect(sut?.numberOfElements()).to(equal(7))
                }
                
                it("allows direct access"){
                    let zero:Int = sut!.elementAt(index: 0) as! Int
                    let one:Int  = sut!.elementAt(index: 1) as! Int
                    let six:Int  = sut!.elementAt(index: 6) as! Int
                    
                    expect(zero).to(equal(0))
                    expect(one ).to(equal(1))
                    expect(six ).to(equal(6))
                }
            }
        }
    }
}

class SectionCellsFactorySpec: QuickSpec {
    
    override func spec() {
        describe("SectionCellsFactory prepares cell models"){
            
            context("providing Ints"){
                var sut: SectionCellsFactory<Int, UITableViewCell>?
                let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 960))
                
                beforeEach {
                    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                    let provider = SectionDataProvider<Int>(reuseIdentifer: {
                        (elm, indexPath) -> String in
                        return "Cell"
                    })
                    sut = SectionCellsFactory(populatorView: tableView, provider: provider){
                        configuration in
                        configuration.cell.textLabel?.text = "\(configuration.element)"
                        return configuration.cell
                    }
                    provider.provideElements(Array(0 ..< 7))
                    
                }
                
                it("prepares 7 cell models"){
                    expect(sut?.cellModels().count).to(equal(7))
                }
            }
        }
    }
}

class TextCollectionCell: UICollectionViewCell {
    var textLabel: UILabel?
}

class PopulatorSpec: QuickSpec {
    override func spec() {
        
        context("populate collection view"){
            context("Populator creation"){
                
                let layout = UICollectionViewFlowLayout()
                layout.itemSize = CGSize(width: 30, height: 30)
                let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 960), collectionViewLayout: layout)
                var sut: Populator<ViewPopulator>?
                
                beforeEach {
                    collectionView.register(TextCollectionCell.self, forCellWithReuseIdentifier: "Cell")
                    let provider = SectionDataProvider<Int>(reuseIdentifer: {
                        (elm, indexPath) -> String in
                        return "Cell"
                    })
                    
                    provider.provideElements(Array(0 ..< 7))
                    let sectionFactory = SectionCellsFactory<Int, TextCollectionCell>(populatorView: collectionView, provider: provider) {
                        configuration in
                        configuration.cell.textLabel?.text = "\(configuration.element)"
                        return configuration.cell
                    }
                    
                    sut = Populator(with: collectionView, sectionCellModelsFactories: [sectionFactory])
                }
                
                it("populates 1 section with 7 cells"){
                    expect(sut).toNot(beNil())
                    expect(collectionView.numberOfItems(inSection: 0)).to(equal(7))
                }
            }
        }
        
        
        describe("populate table view") {
            
            context("Populator creation"){
                let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 960))
                var sut: Populator<ViewPopulator>?
                
                beforeEach {
                    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                    
                    let provider = SectionDataProvider<Int>(reuseIdentifer: {
                        (elm, indexPath) -> String in
                        return "Cell"
                    })
                    
                    provider.provideElements(Array(0 ..< 7))
                    let sectionFactory = SectionCellsFactory<Int, UITableViewCell>(populatorView: tableView, provider: provider) {
                        configuration in
                        configuration.cell.textLabel?.text = "\(configuration.element)"
                        return configuration.cell
                    }
                    
                    sut = Populator(with: tableView, sectionCellModelsFactories: [sectionFactory])
                }
                
                it("populates 1 section with 7 cells"){
                    expect(sut).toNot(beNil())
                    expect(tableView.numberOfRows(inSection: 0)).to(equal(7))
                }
            }
            
            context("re-providing"){
                let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 960))
                var sut: Populator<ViewPopulator>?
                var sectionCellFactory: SectionCellsFactory<Int, UITableViewCell>?
                
                var provider: SectionDataProvider<Int>?
                beforeEach {
                    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                    
                    provider = SectionDataProvider<Int>(reuseIdentifer: {
                        (elm, indexPath) -> String in
                        return "Cell"
                    })
                    
                    provider!.provideElements(Array(0 ..< 7))
                    sectionCellFactory = SectionCellsFactory<Int, UITableViewCell>(populatorView: tableView, provider: provider!) {
                        configuration in
                        configuration.cell.textLabel?.text = "\(configuration.element)"
                        return configuration.cell
                    }
                    
                    
                    sut = Populator(with: tableView, sectionCellModelsFactories: [sectionCellFactory!])
                }
                
                it("re-providing elements will trigger reload") {
                    var reloaded = false
                    sectionCellFactory?.elementsDidReload = {
                        reloaded = true
                        tableView.reloadData()
                    }
                    provider!.provideElements(Array(100 ..< 120))
                    
                    expect(sut).toNot(beNil())
                    expect(reloaded).to(beTrue())
                    expect(tableView.numberOfRows(inSection: 0)).to(equal(20))
                }
            }
        }
    }
}

class ViewPopulatorSpec: QuickSpec {
    override func spec() {
        context("ViewPopulator for TableView"){
            var sut: ViewPopulator?
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 960))
            beforeEach {
                
                let provider = SectionDataProvider<Int>(reuseIdentifer: {
                    (elm, indexPath) -> String in
                    return "Cell"
                })
                
                provider.provideElements(Array(0 ..< 7))
                let sectionCellFactory = SectionCellsFactory<Int, UITableViewCell>(populatorView: tableView, provider: provider) {
                    configuration in
                    configuration.cell.textLabel?.text = "\(configuration.element)"
                    return configuration.cell
                }
                
                sut = ViewPopulator(populatorView: tableView, sectionCellModelsFactories: [sectionCellFactory])
            }
            
            it("parent view is the tableview"){
                
                let view = sut!.populatorView!
                expect(view).to(be(tableView))
                
            }
        }
        
        context("ViewPopulator for CollectionView"){
            var sut: ViewPopulator?
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 30, height: 30)
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 960), collectionViewLayout: layout)
            
            beforeEach {
                
                let provider = SectionDataProvider<Int>(reuseIdentifer: {
                    (elm, indexPath) -> String in
                    return "Cell"
                })
                
                provider.provideElements(Array(0 ..< 7))
                let sectionCellFactory = SectionCellsFactory<Int, UITableViewCell>(populatorView: collectionView, provider: provider) {
                    configuration in
                    configuration.cell.textLabel?.text = "\(configuration.element)"
                    return configuration.cell
                }
                
                sut = ViewPopulator(populatorView: collectionView, sectionCellModelsFactories: [sectionCellFactory])
            }
            
            it("parent view is the collectionView"){
                
                let view = sut!.populatorView!
                expect(view).to(be(collectionView))
                
            }
        }
    }
}


class ViewControllerSpec : QuickSpec {
    
    override func spec() {
        
        context("TableView") {
            var sut: MockViewController<UITableView>!
            
            beforeEach {
                let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 960))
                sut = MockViewController<UITableView>()
                
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                sut.view.frame = tableView.bounds
                sut.populatorView = tableView
                
                _ = sut.view
                
            }
            
            it("gets populated"){
                var tableView: UITableView?
                
                if let populatorView = sut.populatorView as? UITableView {
                    tableView = populatorView
                }
                expect(tableView).toNot(beNil())
                expect(tableView!.numberOfRows(inSection: 0)).to(equal(4))
                expect(tableView!.numberOfRows(inSection: 0)).toEventually(equal(6))
                expect(tableView!.numberOfRows(inSection: 1)).toEventually(equal(3))
            }
            
            it("cells have dfferent sizes") {
                let tableView = sut.populatorView as! UITableView
                let cell1 = tableView.visibleCells[0]
                let cell2 = tableView.visibleCells[1]
                let cell3 = tableView.visibleCells[2]

                expect(cell1.frame.size.height).to(equal(44))
                expect(cell2.frame.size.height).to(equal(49))
                expect(cell3.frame.size.height).to(equal(54))
            }
            
            it("first section has no header") {
                let tv = sut.populatorView as! UITableView
                let header = tv.delegate!.tableView!(tv, viewForHeaderInSection: 0)
                
                expect(header).to(beNil())
            }
            
            it("second section has a header") {
                let tableView = sut.populatorView as! UITableView
                let header = tableView.delegate!.tableView!(tableView, viewForHeaderInSection: 1) as? UITableViewHeaderFooterView
                
                expect(header).toNot(beNil())
                expect(header!.frame.size.height).to(equal(40))
                expect(header!.contentView.backgroundColor).to(equal(UIColor.red))
            }
            
            it("first section has no footer") {
                let tableView = sut.populatorView as! UITableView
                let footer = tableView.delegate!.tableView?(tableView, viewForFooterInSection: 0)
                
                expect(footer).to(beNil())
            }
            
            it("second section has a footer") {
                let tableView = sut.populatorView as! UITableView
                let footer = tableView.delegate!.tableView?(tableView, viewForFooterInSection: 1) as? UITableViewHeaderFooterView
                
                expect(footer).toNot(beNil())
                expect(footer!.frame.size.height).to(equal(60))
                expect(footer!.contentView.backgroundColor).to(equal(UIColor.cyan))
            }
        }
        
        context("CollectionView") {
            var sut: MockViewController<UICollectionView>!
            
            beforeEach {
                let layout = UICollectionViewFlowLayout()
                layout.itemSize = CGSize(width: 30, height: 30)
                let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 960), collectionViewLayout: layout)
                sut = MockViewController<UICollectionView>()
                sut.view.frame = collectionView.bounds
                sut.populatorView = collectionView
                _ = sut.view
            }
            
            it("gets populated"){
                var collectionView: UICollectionView?
                if let populatorView = sut.populatorView as? UICollectionView {
                    collectionView = populatorView
                }
                
                expect(collectionView).toNot(beNil())
                expect(collectionView!.numberOfItems(inSection: 0)).to(equal(4))
                expect(collectionView!.numberOfItems(inSection: 0)).toEventually(equal(6))
                expect(collectionView!.numberOfItems(inSection: 1)).toEventually(equal(3))
            }
        }
    }
    
}
