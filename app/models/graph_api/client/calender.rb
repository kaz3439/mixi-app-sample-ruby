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
# = app/models/graph_api/client/calender.rb - Calender API用クラス
#

require 'json'

require_relative 'base'

module GraphApi
  module Client

    #
    #
    # = Description
    # Calender APIを叩くためのクラス
    #
    # = USAGE
    # #ユーザのTokenを渡して初期化する
    # token = GraphApi::Client::Token.create("etgea4323dd")
    # token.get!("agfeaefgrbvgarhraegf45tqgravdfagqatwrb5b42")
    # calender = GraphApi::Client::Calender.new(token)
    #
    # #スケジュールを投稿する
    # calender = GraphApi::Calender.new(token)
    # body = {
    #   startDatetimes: Time.now + 3.days,
    #   title: "test",
    #   description: "test",
    #   invite: 0,
    #   privacy: {
    #     visibility: "everyone",
    #   },
    #   attendees: []
    # }
    # calender.post_schedule(body)
    class Calender < GraphApi::Client::Base

      ENDPOINT_PREFIX = '/2/calendar/schedules'

      # 自分のuser dataを取得する
      # ---
      # *Arguments*
      # body_obj: Hash
      # *Returns*:: JSONレスポンス: Hash
      def post_my_schedule(body_obj={})
        req_body_obj = { startDatetimes: Time.now }.merge(body_obj)
        req_body_obj[:startDatetimes] = req_body_obj[:startDatetimes].strftime("%Y-%m-%dT%H:%M:%S+09:00")
        body_json = JSON.generate(req_body_obj);
        options = { body: body_json }
        post(self.endpoint_myself(ENDPOINT_PREFIX), options)
      end

    end #Calender
  end #Client
end #GraphApiClient
