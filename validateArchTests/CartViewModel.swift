import Combine
import XCTest
@testable import validateArch

class CombineTests: XCTestCase {
    var cancellables = Set<AnyCancellable>() // Para gerenciar subscrições

    func testSink() {
        // Crie um publisher
        let subject = PassthroughSubject<String, Never>()

        // Defina uma expectativa
        let expectation = XCTestExpectation(description: "O valor é recebido pelo subscriber")

        var receivedValues = [String]() // Para armazenar valores recebidos

        // Subscreva ao publisher usando .sink
        subject.sink { value in
            receivedValues.append(value) // Armazene o valor recebido
            expectation.fulfill() // Indique que a expectativa foi atendida
        }
        .store(in: &cancellables) // Adicione à lista de subscrições

        // Emita um valor
        subject.send("Olá, Combine!")

        // Aguarde até que a expectativa seja cumprida
        wait(for: [expectation], timeout: 1.0)

        // Verifique se o valor foi recebido conforme esperado
        XCTAssertEqual(receivedValues, ["Olá, Combine!"])
    }
}
