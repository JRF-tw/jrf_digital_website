# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'open-uri'
include ActionView::Helpers

def get_img_url_from_html(html)
  doc = Nokogiri::HTML(html)
  img_url = nil
  og_img = doc.css("meta[property='og:image']").first
  if og_img
    img_url = og_img.attributes["content"]
  end
  if img_url.blank?
    img = doc.xpath("//img[@src[contains(.,'://') and not(contains(.,'ads.') or contains(.,'ad.') or contains(.,'?'))]][1]")
    if img.any?
      img_url = img.first.attr('src')
    end
  end
  img_url = nil if img_url.blank?
  return img_url
end

Record.delete_all
Keyword.delete_all
Subject.delete_all
Category.delete_all
Carrier.delete_all
Collector.delete_all
Column.delete_all
Issue.delete_all
Language.delete_all
Pattern.delete_all

ActiveRecord::Base.connection.execute("Delete from keywords_records;");
ActiveRecord::Base.connection.execute("Delete from records_subjects;");

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

record_path = Rails.root.join('db', 'data', 'records.json')

if File.file?(record_path)
  File.readlines(record_path).each do |line|
    record_data = JSON.parse(line)
    record = Record.new
    # 資料識別碼
    record.identifier = record_data[3]
    # 敏感資料與否
    record.sensitive = (record_data[4].empty? ? false : true)
    # 文件標題
    record.title = record_data[5]
    # 貢獻者
    record.contributor = record_data[6]
    # 出版者
    record.publisher = record_data[8]
    # 產生日期
    record.date = (record_data[10].empty? ? nil : Date.parse(record_data[10]))
    # 資料格式-單位
    record.unit = record_data[11]
    # 資料格式-大小
    record.size = record_data[12]
    # 資料格式-面數
    record.page = record_data[13]
    # 檔案數量
    record.quantity = record_data[14]
    # 主題
    # record.subject = record_data[16]
    # 目次∕附件
    record.catalog = record_data[18]
    # 內容描述
    record.content = record_data[19]
    # 對應資訊
    record.information = record_data[20]
    # 附註項
    record.comment = record_data[22]
    # 原件權利-著作權
    record.copyright = record_data[23]
    # 原件權利-財產物權
    record.right_in_rem = record_data[24]
    # 數位檔權利-所有權人
    record.ownership = record_data[25]
    # 數位檔權利-公開與否
    record.published = (record_data[26].empty? ? false : true)
    # 數位檔權利-授權狀況
    record.licence = record_data[27]
    # 數位檔連結-檔案名稱
    record.filename = record_data[28]
    # 數位檔連結-檔案格式
    record.filetype = record_data[29]
    # 建目記錄-登錄者
    record.creator = record_data[30]
    # 建目記錄-建檔日期
    record.created_at = (record_data[31].empty? ? nil : Date.parse(record_data[31]))
    # 建目記錄-描述者
    record.commentor = record_data[32]
    # 建目記錄-描述日期
    record.commented_at = (record_data[33].empty? ? nil : Date.parse(record_data[33]))
    # 建目記錄-修改者
    record.updater = record_data[34]
    # 建目記錄-修改日期
    record.updated_at = (record_data[35].empty? ? nil : Date.parse(record_data[35]))
    # 資料類型-資源類型
    unless record_data[0].empty?
      category_id = Category.where(name: record_data[0]).first.try(:id)
      unless category_id
        category_id = Category.create({name: record_data[0]}).id
      end
      record.category_id = category_id
    end
    # 資料類型-載體
    unless record_data[1].empty?
      carrier_id = Carrier.where(name: record_data[1]).first.try(:id)
      unless carrier_id
        carrier_id = Carrier.create({name: record_data[1]}).id
      end
      record.carrier_id = carrier_id
    end
    # 資料類型-型式
    unless record_data[2].empty?
      pattern_id = Pattern.where(name: record_data[2]).first.try(:id)
      unless pattern_id
        pattern_id = Pattern.create({name: record_data[2]}).id
      end
      record.pattern_id = pattern_id
    end
    # 案名
    unless record_data[7].empty?  
      issue_id = Issue.where(name: record_data[7]).first.try(:id)
      unless issue_id
        issue_id = Issue.create({name: record_data[7]}).id
      end
      record.issue_id = issue_id
    end
    # 語言
    unless record_data[15].empty?
      language_id = Language.where(name: record_data[15]).first.try(:id)
      unless language_id
        language_id = Language.create({name: record_data[15]}).id
      end
      record.language_id = language_id
    end
    # 典藏單位
    unless record_data[21].empty?
      collector_id = Collector.where(name: record_data[21]).first.try(:id)
      unless collector_id
        collector_id = Collector.create({name: record_data[21]}).id
      end
      record.collector_id = collector_id
    end
    # 主題
    subjects = record_data[16].split('、')
    subjects.each do |k|
      subject = Subject.where(name: k).first
      unless subject
        subject = Subject.create({name: k})
      end
      record.subjects << subject
    end
    # 關鍵字
    keywords = record_data[17].split('、')
    keywords.each do |k|
      keyword = Keyword.where(name: k).first
      unless keyword
        keyword = Keyword.create({name: k})
      end
      record.keywords << keyword
    end
    record.save
  end
end

Magazine.delete_all
Column.delete_all
Article.delete_all

ActiveRecord::Base.connection.execute("Delete from articles_keywords;");

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

magazine_path = Rails.root.join('db', 'data', 'magazines.json')
#["標題","作者","卷","期","日期","專欄","全文","註釋"]
if File.file?(magazine_path)
  magazines = JSON.parse(File.read(magazine_path))
  magazines.each do |article_data|
    # puts article_data.to_json
    article = Article.new
    magazine = Magazine.where(issue: article_data["期"]).first
    unless magazine
      magazine = Magazine.new
      magazine.issue = article_data["期"]
      magazine.id = article_data["期"]
      published_at = Date.parse(article_data["日期"])
      magazine.published_at = published_at
      magazine.name = "司改雜誌第#{article_data["期"]}期"
      magazine.created_at = published_at
      magazine.save
    end
    article.magazine = magazine
    if article_data["專欄"].blank?
      article_data["專欄"] = "其他"
    end
    column = Column.where(name: article_data["專欄"]).first
    unless column
      column = Column.new
      column.name = article_data["專欄"]
      column.save
    end
    if article_data["專欄"] == "封面故事"
      article.is_cover = true
    end
    article.column = column
    article.page = article_data["頁碼"]
    article.title = article_data["標題"].gsub(/\n/, '')
    article.author = article_data["作者"]
    article.content = simple_format(article_data["全文"]).gsub(/\n/, '')
    img_url = get_img_url_from_html(article.content)
    if img_url
      article.remote_image_url = img_url
    end
    article.comment = simple_format(article_data["註釋"]).gsub(/\n/, '')
    article.save
  end
end


ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end