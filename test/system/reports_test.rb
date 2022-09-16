# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    # トップページにアクセスする
    visit root_url
    # email アドレスを入力する
    fill_in 'Eメール', with: 'alice@example.com'
    # パスワードを入力する
    fill_in 'パスワード', with: 'password'
    # ログインボタンをクリックする
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
    assert_text 'こんにちは'
    assert_text 'alice@example.com'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'タイトルテスト'
    fill_in '内容', with: '内容テスト'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'タイトルテスト'
    assert_text '内容テスト'
  end

  test 'updating a Report' do
    visit reports_url
    assert_no_text 'こんばんは'

    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: 'こんばんは'
    fill_in '内容', with: 'Good Evening from Alice!'
    click_on '更新する'

    assert_text '日報が更新されました。'
    click_on '戻る'

    assert_selector 'h1', text: '日報'
    assert_text 'こんばんは'
  end

  test 'destroying a Report' do
    visit reports_url

    assert_text 'こんにちは'

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
    assert_no_text 'こんにちは'
  end

  test 'back link from report create page' do
    visit reports_url
    click_on '新規作成'
    click_on '戻る'
    assert_selector 'h1', text: '日報'
  end
end
