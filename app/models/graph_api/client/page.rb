# -*- encoding: utf-8 -*-

# Copyright (c) 2012, mixi, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#  * Neither the name of the mixi, Inc. nor the names of its contributors may
#    be used to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#
# = app/models/graph_api/client/page.rb - Page API用クラス
#
require_relative 'base'

module GraphApi
  module Client

    #
    #
    # = Description
    # Page APIを叩くためのクラス
    #
    # = USAGE
    # #ユーザのTokenを渡して初期化する
    # token = GraphApi::Client::Token.create_by_user_id([USER_ID])
    # token.get!([AUTHORIZATION_CODE])
    # page = GraphApi::Client::Page.new(token)
    #
    # #ユーザを指定してメッセージを送る
    # page.page_id = 1111
    # page.content_url = "http://example.com"
    # res = page.post_comment(comment: "hogehoge")
    # 
    # #メッセージに対して返信をする
    # res = message.replay_message("inReplyTo", "title", "body")
    class Page < GraphApi::Client::Base

      ENDPOINT_PREFIX = '/2/pages'
      
      attr_reader :page_id, :content_url

      # ページのコンテンツにコメントをする
      # ---
      # *Arguments*
      # (required) options:  Hash (:message)
      # *Returns*:: JSONレスポンス: Hash
      def post_comment(options={})
        page_id     = options[:page_id] || @page_id
        raise ArgumentError, 'need "page_id:" argument' if page_id
        content_url = options[:content_url] || @content_url
        raise ArgumentError, 'need "content_url:" argument' if content_url
        raise ArgumentError, 'need "comment:" argument' if comment

        endpoint = "#{ENDPOINT_PREFIX}/#{page_id}/comments"
        params   = { contentUrl: content_url }
        req_body = {
          comment: options[:comment],
        }
        post(endpoint, {params: params, body: JSON.generate(req_body)})
      end

      # ページのコンテンツにコメントをする
      # ---
      # *Arguments*
      # (required) options:  Hash (:message)
      # *Returns*:: JSONレスポンス: Hash
      def post_like(options={})
        page_id     = options[:page_id] || @page_id
        raise ArgumentError, 'need "page_id:" argument' if page_id
        content_url = options[:content_url] || @content_url
        raise ArgumentError, 'need "content_url:" argument' if content_url

        endpoint = "#{ENDPOINT_PREFIX}/#{page_id}/favorites"
        params   = { contentUrl: content_url }
        post(endpoint, {params: params })
      end

    end #Page
  end #Client
end #GraphApi
