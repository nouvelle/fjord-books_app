# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?: 本人が作成したレポートであれば true, 別のユーザが作成していれば false を返す' do
    # alice と bob のアカウントを作成
    alice = users(:alice)
    bob = users(:bob)

    # alice が report を作成
    alice_report = reports(:report_alice)

    # alice が 作成した report であることをチェック
    assert alice_report.editable?(alice)
    # bob が 作成した report でないことをチェック
    assert_not alice_report.editable?(bob)
  end

  test '#created_on: レポートの作成日を返す' do
    # alice が report を作成
    alice_report = reports(:report_alice)

    # alice が 作成した report のレポート作成日が今日であることをチェック
    assert Time.zone.today, alice_report.created_on
  end
end
