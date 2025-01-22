//
//  notHavebookings.swift
//  Momtaz-IOS
//
//  Created by Mohamed Abd Elhakam on 21/01/2025.
//

import UIKit


enum BookingState {
    case inProgress
    case finished
    case canceled
}


class notHavebookings: UIView {
    
    
    private var bookingState: BookingState
    private let messageLabel: UILabel
    private let imageView: UIImageView
    private let stackView: UIStackView
    
    // Initialize the ProgressView with the booking state
    init(bookingState: BookingState) {
        self.bookingState = bookingState
        self.messageLabel = UILabel()
        self.imageView = UIImageView()
        self.stackView = UIStackView()

        super.init(frame: .zero)
        setupView()
        updateMessage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        // Set up the image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "notHaveBookingImage")
        
        // Set up the message label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textColor = UIColor.darkGrey
        messageLabel.numberOfLines = 0
        
        // Set up the stack view to hold the image and label
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        // Add the image view and label to the stack view
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)
        
        // Add the stack view to the main view
        addSubview(stackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        // Set constraints for the image view (200x200 size)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // Update the message label based on the booking state
       private func updateMessage() {
           switch bookingState {
           case .inProgress:
               messageLabel.text = Constants.notHaveProgressBookingHead
           case .finished:
               messageLabel.text = Constants.notHaveFinishedBooking
           case .canceled:
               messageLabel.text = Constants.notHaveCancelledBooking
           }
       }

       // Public method to update the booking state and refresh the message
       func setBookingState(_ state: BookingState) {
           self.bookingState = state
           updateMessage()
       }
}
