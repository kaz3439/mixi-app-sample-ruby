# encoding: utf-8

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
# = app/models/graph_api/client/voice.rb - Voice API用クラス
#
# *Reference* 
#  http://developer.mixi.co.jp/connect/mixi_graph_api/mixi_io_spec_top/voice-api/
require_relative 'base'

module GraphApi
  module Client

    #
    #
    # = Description
    # Voice APIを叩くためのクラス
    #
    # = USAGE
    # #ユーザのTokenを渡して初期化する
    # token = GraphApi::Client::Token.create_by_user_id([USER_ID])
    # token.oauth.set!([CONSUMER_KEY], [CONSUMER_SECRET], [REDIRECT_URL])
    # token.get!([AUTHORIZATION_CODE])
    # voice = GraphApi::Client::Voice.new(token)
    #
    # #つぶやきを投稿する
    # res = voice.post_voice
    class Voice < GraphApi::Client::Base

      ENDPOINT_PREFIX = '/2/voice'

      # つぶやきの投稿
      # ---
      # *Arguments*
      # (optional) status: String
      # (optional) other_params: Hash
      # *Returns*:: JSONレスポンス: Hash
      def post_voice(status='おっぱい', other_params={})
        endpoint    = "#{ENDPOINT_PREFIX}/statuses"
        body_params = { status: status }.merge(other_params)
        body_str    = body_params.map{|param, val| URI.encode("#{param}=#{val}") }.join('&')
        headers     = {'Content-Type' => 'application/x-www-form-urlencoded'}
        options     = { headers: headers, body: body_str }
        post(endpoint, options)
      end

    end #Voice
  end #Client
end #GraphApi
