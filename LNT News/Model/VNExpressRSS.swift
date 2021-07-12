//
//  VNExpressRSS.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 02/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

enum VNExpressCategory : String, CaseIterable{
    case trang_chu = "Trang chủ"
    case suc_khoe = "Sức khoẻ"
    case the_gioi = "Thế giới"
    case doi_song = "Đời Sống"
    case thoi_su = "Thời sự"
    case du_lich = "Du lịch"
    case kinh_doanh = "Kinh doanh"
    case khoa_hoc = "Khoa học"
    case startup = "Start up"
    case so_hoa = "Số hoá"
    case giai_tri = "Giải trí"
    case xe = "Xe"
    case the_thao = "Thể thao"
    case y_kien = "Ý kiến"
    case phap_luat = "Pháp luật"
    case tam_su = "Tâm sự"
    case giao_duc = "Giáo dục"
    case cuoi = "Cười"
    case tin_xem_nhieu = "Xem nhiều"
    case tin_noi_bat = "Nổi bật"
}



var allVNExpressRss: [VNExpressCategory: String] = [
    .trang_chu: "https://vnexpress.net/rss/tin-moi-nhat.rss",
    .the_gioi: "https://vnexpress.net/rss/the-gioi.rss",
    .thoi_su: "https://vnexpress.net/rss/thoi-su.rss",
    .kinh_doanh: "https://vnexpress.net/rss/kinh-doanh.rss",
    .startup: "https://vnexpress.net/rss/startup.rss",
    .giai_tri: "https://vnexpress.net/rss/giai-tri.rss",
    .the_thao: "https://vnexpress.net/rss/the-thao.rss",
    .phap_luat: "https://vnexpress.net/rss/phap-luat.rss",
    .giao_duc: "https://vnexpress.net/rss/giao-duc.rss",
    .tin_noi_bat: "https://vnexpress.net/rss/tin-noi-bat.rss",
    .suc_khoe: "https://vnexpress.net/rss/suc-khoe.rss",
    .doi_song: "https://vnexpress.net/rss/doi-song.rss",
    .du_lich: "https://vnexpress.net/rss/du-lich.rss",
    .khoa_hoc: "https://vnexpress.net/rss/khoa-hoc.rss",
    .so_hoa: "https://vnexpress.net/rss/so-hoa.rss",
    .xe: "https://vnexpress.net/rss/xe.rss",
    .y_kien: "https://vnexpress.net/rss/y-kien.rss",
    .tam_su: "https://vnexpress.net/rss/tam-su.rss",
    .cuoi: "https://vnexpress.net/rss/cuoi.rss",
    .tin_xem_nhieu: "https://vnexpress.net/rss/tin-xem-nhieu.rss"
]

