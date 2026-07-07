import XCTest
@testable import SneakerShelf

@MainActor
final class SneakerShelfTests: XCTestCase {
    var store: SneakerShelfStore!

    override func setUp() {
        super.setUp()
        store = SneakerShelfStore()
    }

    func testSeedDataLoadedOnFreshInstall() {
        XCTAssertFalse(store.entries.isEmpty)
    }

    func testSeedCountIsBelowFreeLimit() {
        XCTAssertLessThan(SneakerShelfStore.seedData().count, SneakerShelfStore.freeLimit)
    }

    func testAddEntrySucceedsUnderLimit() {
        let before = store.entries.count
        let added = store.add(SneakerEntry(name: "Test Entry", detail: "Detail", date: Date()))
        XCTAssertTrue(added)
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testAddEntryFailsAtLimit() {
        while store.canAddMore {
            store.add(SneakerEntry(name: "Filler", detail: "x", date: Date()))
        }
        let added = store.add(SneakerEntry(name: "Overflow", detail: "x", date: Date()))
        XCTAssertFalse(added)
        XCTAssertEqual(store.entries.count, SneakerShelfStore.freeLimit)
    }

    func testDeleteEntry() {
        let entry = SneakerEntry(name: "ToDelete", detail: "x", date: Date())
        store.add(entry)
        let before = store.entries.count
        store.delete(entry)
        XCTAssertEqual(store.entries.count, before - 1)
    }

    func testUpdateEntry() {
        var entry = SneakerEntry(name: "Original", detail: "x", date: Date())
        store.add(entry)
        entry.name = "Updated"
        store.update(entry)
        XCTAssertEqual(store.entries.first(where: { $0.id == entry.id })?.name, "Updated")
    }

    func testToggleFavorite() {
        let entry = SneakerEntry(name: "Fav", detail: "x", date: Date())
        store.add(entry)
        store.toggleFavorite(entry)
        XCTAssertTrue(store.entries.first(where: { $0.id == entry.id })?.isFavorite ?? false)
    }

    func testCanAddMoreReflectsLimit() {
        XCTAssertTrue(store.canAddMore)
    }
}
