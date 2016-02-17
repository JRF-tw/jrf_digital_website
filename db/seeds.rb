# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'open-uri'
include ActionView::Helpers

def reset_pk_sequence(table)
  case ActiveRecord::Base.connection.adapter_name.downcase
  when 'sqlite'
    ActiveRecord::Base.connection.execute("UPDATE sqlite_sequence SET seq = 0 WHERE name = '#{table.table_name}';") rescue nil
  when 'postgresql'
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end

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
Issue.delete_all
Language.delete_all
Pattern.delete_all

ActiveRecord::Base.connection.execute("Delete from keywords_records;");
ActiveRecord::Base.connection.execute("Delete from records_subjects;");

ActiveRecord::Base.connection.tables.each do |t|
  reset_pk_sequence(t)
end

record_path = Rails.root.join('db', 'data', 'records.json')

if File.file?(record_path)
  File.readlines(record_path).each do |line|
    record_data = JSON.parse(line)
    unless record_data and record_data.length == 36
      puts "[格式不正確] #{line}"
      next
    end

    record = Record.new
    # 資料識別碼
    record.identifier = record_data[3].strip
    # 敏感資料與否
    record.sensitive = (record_data[4].blank? ? false : true)
    # 文件標題
    record.title = record_data[5].strip
    # 貢獻者
    record.contributor = record_data[6].strip
    # 出版者
    record.publisher = record_data[8].strip
    # 產生日期
    record.date = (record_data[10].blank? ? nil : Date.parse(record_data[10]))
    # 資料格式-單位
    record.unit = record_data[11].strip
    # 資料格式-大小
    record.size = record_data[12].strip
    # 資料格式-面數
    record.page = record_data[13].gsub(/頁/, '')
    # 檔案數量
    record.quantity = record_data[14].strip
    # 主題
    # record.subject = record_data[16]
    # 目次∕附件
    record.catalog = record_data[18].strip
    # 內容描述
    record.content = record_data[19].strip
    # 對應資訊
    record.information = record_data[20].strip
    # 附註項
    record.comment = record_data[22].strip
    # 原件權利-著作權
    record.copyright = record_data[23].strip
    # 原件權利-財產物權
    record.right_in_rem = record_data[24].strip
    # 數位檔權利-所有權人
    record.ownership = record_data[25].strip
    # 數位檔權利-公開與否
    record.published = (record_data[26].blank? ? false : true)
    # 數位檔權利-授權狀況
    record.licence = record_data[27].strip
    # 數位檔連結-檔案名稱
    record.filename = record_data[28].strip
    # 數位檔連結-檔案格式
    record.filetype = record_data[29].strip
    # 建目記錄-登錄者
    record.creator = record_data[30].strip
    # 建目記錄-建檔日期
    record.created_at = (record_data[31].blank? ? nil : Date.parse(record_data[31]))
    # 建目記錄-描述者
    record.commentor = record_data[32].strip
    # 建目記錄-描述日期
    record.commented_at = (record_data[33].blank? ? nil : Date.parse(record_data[33]))
    # 建目記錄-修改者
    record.updater = record_data[34].strip
    # 建目記錄-修改日期
    record.updated_at = (record_data[35].blank? ? nil : Date.parse(record_data[35]))
    # 資料類型-資源類型
    unless record_data[0].blank?
      category_id = Category.where(name: record_data[0].strip).first.try(:id)
      unless category_id
        category_id = Category.create({name: record_data[0].strip}).id
      end
      record.category_id = category_id
    end
    # 資料類型-載體
    unless record_data[1].blank?
      carrier_id = Carrier.where(name: record_data[1].strip).first.try(:id)
      unless carrier_id
        carrier_id = Carrier.create({name: record_data[1].strip}).id
      end
      record.carrier_id = carrier_id
    end
    # 資料類型-型式
    unless record_data[2].blank?
      pattern_id = Pattern.where(name: record_data[2].strip).first.try(:id)
      unless pattern_id
        pattern_id = Pattern.create({name: record_data[2].strip}).id
      end
      record.pattern_id = pattern_id
    end
    # 案名
    unless record_data[7].blank?
      issue_id = Issue.where(name: record_data[7].strip).first.try(:id)
      unless issue_id
        issue_id = Issue.create({name: record_data[7].strip}).id
      end
      record.issue_id = issue_id
    end
    # 語言
    unless record_data[15].blank?
      language_id = Language.where(name: record_data[15].strip).first.try(:id)
      unless language_id
        language_id = Language.create({name: record_data[15].strip}).id
      end
      record.language_id = language_id
    end
    # 典藏單位
    unless record_data[21].blank?
      collector_id = Collector.where(name: record_data[21].strip).first.try(:id)
      unless collector_id
        collector_id = Collector.create({name: record_data[21].strip}).id
      end
      record.collector_id = collector_id
    end
    # 主題
    subjects = record_data[16].split('、').map{ |s| s.strip }
    subjects.each do |s|
      subject = Subject.where(name: s).first
      unless subject
        subject = Subject.create({name: s})
      end
      if not record.subjects.include? subject
        record.subjects << subject
      end
    end
    # 關鍵字
    keywords = record_data[17].split('、').map{ |k| k.strip }
    keywords.each do |k|
      k.strip!
      keyword = Keyword.where(name: k).first
      unless keyword
        keyword = Keyword.create({name: k})
      end
      if not record.keywords.include? keyword
        record.keywords << keyword
      end
    end
    record.save
  end
end

Magazine.delete_all
Column.delete_all
Article.delete_all
IssueColumn.delete_all

ActiveRecord::Base.connection.execute("Delete from articles_keywords;");

ActiveRecord::Base.connection.tables.each do |t|
  reset_pk_sequence(t)
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
      published_at = Date.strptime(article_data["日期"], "%Y-%m-%d") rescue Date.strptime(article_data["日期"], "%m/%d/%Y")
      magazine.published_at = published_at
      magazine.name = "司改雜誌第 #{article_data["期"]} 期"
      magazine.created_at = published_at
      magazine.save
    end
    if article_data["專欄"].blank?
      article_data["專欄"] = "其他"
    end
    column = Column.where(name: article_data["專欄"]).first
    unless column
      column = Column.new
      column.name = article_data["專欄"]
      column.save
    end
    article_page = article_data["頁碼"]
    issue_column = IssueColumn.where(magazine: magazine, column: column).first
    unless issue_column
      issue_column = IssueColumn.new
      issue_column.magazine = magazine
      issue_column.column = column
      issue_column.page = article_page
    end
    if issue_column.page > article_page
      issue_column.page = article_page
      issue_column.save
    end
    article.issue_column = issue_column
    if article_data["專欄"] == "封面故事"
      article.is_cover = true
    end
    article.page = article_page
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
  reset_pk_sequence(t)
end
