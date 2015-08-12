class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  private

  def filter_record(record)
    return {
      id: record.id,
      identifier: record.identifier,
      #category: record.category.try(:name),
      category: record.category,
      #carrier: record.carrier.try(:name),
      carrier: record.carrier,
      #pattern: record.pattern.try(:name),
      pattern: record.pattern,
      #issue: record.issue.try(:name),
      issue: record.issue,
      #language: record.language.try(:name),
      language: record.language,
      #collector: record.collector.try(:name),
      collector: record.collector,
      #keywords: record.keywords.map { |k| k[:name] },
      keywords: record.keywords,
      sensitive: record.sensitive,
      title: record.title,
      contributor: record.contributor,
      publisher: record.publisher,
      date: (record.date ? record.date.strftime('%Y-%m-%d') : nil),
      unit: record.unit,
      size: record.size,
      page: record.page,
      quantity: record.quantity,
      subject: record.subject,
      catalog: record.catalog,
      content: record.content,
      information: record.information,
      comment: record.comment,
      copyright: record.copyright,
      right_in_rem: record.right_in_rem,
      ownership: record.ownership,
      published: record.published,
      licence: record.licence,
      filename: record.filename,
      filetype: record.filetype,
      creator: record.creator,
      created_at: (record.created_at ? record.created_at.strftime('%Y-%m-%d') : nil),
      commentor: record.commentor,
      commented_at: (record.commented_at ? record.commented_at.strftime('%Y-%m-%d') : nil),
      updater: record.updater,
      updated_at: (record.updated_at ? record.updated_at.strftime('%Y-%m-%d') : nil),
    }
  end

  def filter_records(records)
    return records.to_a.map { |r| filter_record(r) }
  end
end
