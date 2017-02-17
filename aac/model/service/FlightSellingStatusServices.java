/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.domain.dataCategory.AACException;
import aac.domain.Flight;
import aac.domain.flight.SeatDistribute;
import aac.model.dao.FlightSellingStatusDAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Walker
 */
public class FlightSellingStatusServices {

    private final FlightSellingStatusDAO fssdao = new FlightSellingStatusDAO();

    public void build(Flight fss) throws AACException {
        fssdao.insert(fss);
        System.out.println("Flight built successfully...");
    }

    public void seatsSelected(Flight fssSelecting, SeatDistribute sdSelecting) throws AACException {
        Flight fssStatus = fssdao.get(fssSelecting.getId());
//        SeatDistribute sdSelecting = fssSelecting.getSeatDistribute();
        SeatDistribute sdStatus = fssStatus.getSeatDistribute();
        List<String> seatsFinished = new ArrayList<>();
        List<String> seatsSelectErrors = new ArrayList<>();
        for (int i = 0; i < SeatDistribute.getColName().length; i++) {
            String sdSelectingColBinStr = sdSelecting.getColBinStr(SeatDistribute.getColName()[i]);
            int sdSelectingColInt = SeatDistribute.getColInt(sdSelectingColBinStr);
//            System.out.println("sdSelectingColBinStr = " + sdSelectingColBinStr);            
            String sdStatusColBinStr = sdStatus.getColBinStr(SeatDistribute.getColName()[i]);
            int sdStatusColInt = SeatDistribute.getColInt(sdStatusColBinStr);
//            System.out.println("sdStatusColBinStr = " + sdStatusColBinStr);
            if ((sdSelectingColInt ^ sdStatusColInt) != (sdSelectingColInt | sdStatusColInt)) {
                seatsSelectErrors.add(SeatDistribute.getColName()[i] + "出現重複選位");
//                System.out.println("sdSelectingColInt ^ sdStatusColInt = " + (sdSelectingColInt ^ sdStatusColInt));
//                System.out.println("sdSelectingColInt | sdStatusColInt = " + (sdSelectingColInt | sdStatusColInt));
            } else {
                seatsFinished.add(SeatDistribute.getColBinStr(sdSelectingColInt ^ sdStatusColInt));
            }
        }
        if (!seatsSelectErrors.isEmpty()) {
            System.out.println("選位失敗!!因為: " + seatsSelectErrors);
        } else {
            for (int i = 0; i < SeatDistribute.getColName().length; i++) {
                String ColBinStr = seatsFinished.get(i);
                fssStatus.getSeatDistribute().setColBinStr(SeatDistribute.getColName()[i], ColBinStr);
            }
            fssdao.seatsSelected(fssStatus);
            System.out.println("Flight seatsSelected successfully...");
        }
    }

    public Flight search(String id) throws AACException {
        return fssdao.get(id);
    }

    public List<Flight> searchAll() throws AACException {
        return fssdao.getAll();
    }
    // 補充資料-讀取器Iterator : http://pclevin.blogspot.tw/2011/12/java-iterator.html
}
