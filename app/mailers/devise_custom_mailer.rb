class DeviseCustomMailer < Devise::Mailer
  helper :application
  default template_path: 'devise/mailer'
  layout 'mailer'
  add_template_helper EmailHelper
  add_template_helper ApplicationHelper

  def confirmation_instructions(record, token, opts={})
    attachments.inline['horse.svg'] = File.read(Rails.root.join('public/images/horse.svg'))
    super
  end

  def reset_password_instructions(record, token, opts={})
    super
  end

  def password_change(record, token, opts={})
    super
  end

  def email_changed(record, token, opts={})
    super
  end


end
