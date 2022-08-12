//
//  FactDetailPresenter.swift
//  Inforu
//
//  Created by Rahul Dhiman on 11/12/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import Foundation
import AFDateHelper

protocol FactDetailPresenterDelegate : class {
    func failure(message: String)
    func fetchDetailSuccess()
}

class FactDetailPresenter {
    
    var factId : Int?
    var factDetailModel : FactDetailModel?
    var totalFactForSwipe = [SearchFactModel]()
    var currentFactIndex = Int()
    
    weak var view  : FactDetailPresenterDelegate?
    
    init(view: FactDetailPresenterDelegate) {
        self.view = view
    }
    
    func getFactDetails() {
        
        guard let factId = self.factId else {
            self.view?.failure(message: "Server Error, Please try again!")
            return
        }
        
        
        UserAPI.share.getFactDetail(factId: factId, callback: { [weak self] response , error in
            
            guard let response = response, error == nil else {
                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.factDetailModel = FactDetailModel(json: response)
            self?.view?.fetchDetailSuccess()
            
        })
        
        
    }
    
    func likeFact(status : Int) {
        
        guard let factId = self.factId else {
            self.view?.failure(message: "Server Error, Please try again!")
            return
        }
        
        UserAPI.share.likeFact(factId: factId, status: status, callback: { [weak self] response , error in
            
            guard response != nil, error == nil else {
//                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.getFactDetails()
        })
        
    }
    
    func addFactFav(status : Int) {
        
        guard let factId = self.factId else {
            self.view?.failure(message: "Server Error, Please try again!")
            return
        }
        
        UserAPI.share.addFactFav(factId: factId, status: status, callback: { [weak self] response , error in
           
            guard response != nil, error == nil else {
//                self?.view?.failure(message:  error?.localizedDescription ?? "Server Error, Please try again!")
                return
            }
            
            self?.getFactDetails()
        })
        
    }
    
    func beautifyPostedDate(date : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let dateUTC = dateFormatter.date(from: date) else {
            return date
        }
        
        dateFormatter.dateFormat = "EEE"
        let dayForBooking = dateFormatter.string(from: dateUTC)
        
        dateFormatter.dateFormat = "dd"
        var dateForBooking = dateFormatter.string(from: dateUTC)
        
        if dateForBooking == "01" || dateForBooking == "21" || dateForBooking == "31" {
            dateForBooking = "\(dateForBooking)st"
        } else if dateForBooking == "02" || dateForBooking == "22" {
            dateForBooking = "\(dateForBooking)nd"
        } else if dateForBooking == "03" || dateForBooking == "23" {
            dateForBooking = "\(dateForBooking)rd"
        } else {
            dateForBooking = "\(dateForBooking)th"
        }
        
        
        dateFormatter.dateFormat = "MMM"
        let monthForBooking = dateFormatter.string(from: dateUTC)
        
        dateFormatter.dateFormat = "yyyy"
        let yearForBooking = dateFormatter.string(from: dateUTC)
        
        let bookingTimeAndDateFormatted = dayForBooking + " " + dateForBooking + " " + monthForBooking + " " + yearForBooking
        
        return bookingTimeAndDateFormatted
        
    }
    
    
}
