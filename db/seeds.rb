# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Record.delete_all

record_path = Rails.root.join('db', 'data', 'records.json')

if File.file?(record_path)
  File.readlines(record_path).each do |line|
    record_data = JSON.parse(line)
    record = Record.new
    record.identifier = record_data[3]
    record.sensitive = (record_data[4].empty? ? false : true)
    record.title = record_data[5]
    record.contributor = record_data[6]
    record.publisher = record_data[8]
    record.date = (record_data[10].empty? ? nil : Date.parse(record_data[10]))
    record.unit = record_data[11]
    record.size = record_data[12]
    record.page = record_data[13]
    record.quantity = record_data[14]
    record.subject = record_data[16]
    record.catalog = record_data[18]
    record.content = record_data[19]
    record.information = record_data[20]
    record.comment = record_data[22]
    record.copyright = record_data[23]
    record.right_in_rem = record_data[24]
    record.ownership = record_data[25]
    record.published = (record_data[26].empty? ? false : true)
    record.licence = record_data[27]
    record.filename = record_data[28]
    record.filetype = record_data[29]
    record.creator = record_data[30]
    record.created_at = (record_data[31].empty? ? nil : Date.parse(record_data[31]))
    record.commentor = record_data[32]
    record.commented_at = (record_data[33].empty? ? nil : Date.parse(record_data[33]))
    record.updater = record_data[34]
    record.updated_at = (record_data[35].empty? ? nil : Date.parse(record_data[35]))
    unless record_data[0].empty?
      category_id = Category.where(name: record_data[0]).first.try(:id)
      unless category_id
        category_id = Category.create({name: record_data[0]}).id
      end
      record.category_id = category_id
    end
    unless record_data[1].empty?
      carrier_id = Carrier.where(name: record_data[1]).first.try(:id)
      unless carrier_id
        carrier_id = Carrier.create({name: record_data[1]}).id
      end
      record.carrier_id = carrier_id
    end
    unless record_data[2].empty?
      pattern_id = Pattern.where(name: record_data[2]).first.try(:id)
      unless pattern_id
        pattern_id = Pattern.create({name: record_data[2]}).id
      end
      record.pattern_id = pattern_id
    end
    unless record_data[7].empty?
      issue_id = Issue.where(name: record_data[7]).first.try(:id)
      unless issue_id
        issue_id = Issue.create({name: record_data[7]}).id
      end
      record.issue_id = issue_id
    end
    unless record_data[15].empty?
      language_id = Language.where(name: record_data[15]).first.try(:id)
      unless language_id
        language_id = Language.create({name: record_data[15]}).id
      end
      record.language_id = language_id
    end
    unless record_data[21].empty?
      collector_id = Collector.where(name: record_data[21]).first.try(:id)
      unless collector_id
        collector_id = Collector.create({name: record_data[21]}).id
      end
      record.collector_id = collector_id
    end
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


ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end