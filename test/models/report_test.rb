# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?: 本人が作成したレポートであれば true, 別のユーザが作成していれば false を返す' do
    # me と you のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')
    you = User.create!(email: 'you@email.com', password: 'password')

    # me が report を作成
    my_report = me.reports.new(user: me, title: 'Title', content: 'Hello World!')
    
    # me が 作成した report であることをチェック
    assert my_report.editable?(me)
    # you が 作成した report でないことをチェック
    assert_not my_report.editable?(you)
  end

  test '#created_on: レポートの作成日を返す' do
    # me のアカウントを作成
    me = User.create!(email: 'me@email.com', password: 'password')

    # me が report を作成
    my_report = me.reports.new(user: me, title: 'Title', content: 'Hello World!', created_at: Date.today)

    # me が 作成した report のレポート作成日が今日であることをチェック
    assert Date.today, my_report.created_on
  end
end
