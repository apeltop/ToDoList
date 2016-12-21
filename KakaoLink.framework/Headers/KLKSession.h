/**
 * Copyright 2016 Kakao Corp.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*!
 @header KLKSession.h
 카카오링크 API 호출을 담당하는 클래스.
 */

#import <Foundation/Foundation.h>

/*!
 @typedef   KLKTalkLinkCompletionHandler
 @abstract  카카오톡 링크 호출 완료시 호출되는 핸들러.
 @param error       오류 정보. 카카오톡 실행에 성공하면 nil.
 @param warnings    경고 목록.<br>
                    key: 템플릿 요소의 key path.<br>
                    value: 경고 내용.
 */
typedef void (^KLKTalkLinkCompletionHandler)(NSError *error, NSDictionary<NSString *, NSString *> *warnings);

/*!
 @class KLKSession
 @abstract 카카오링크 API 호출을 담당하는 클래스.
 */
@interface KLKSession : NSObject

/*!
 @method    sharedSession
 @abstract  현재 session 정보.
 */
+ (instancetype)sharedSession;

/*!
 @method    isOpening
 @abstract  카카오링크 호출 실행중 여부. 한번에 한개의 요청만 처리함.
 */
- (BOOL)isOpening;

/*!
 @method    canOpenTalkLink
 @abstract  카카오톡 링크 실행가능 여부.
 */
- (BOOL)canOpenTalkLink;

/*!
 @method    talkLinkWithTemplateId:args:completion:
 @abstract  카카오톡 링크 호출.
 @param templateId  전송할 메시지 템플릿 ID
 @param args        메시지 템플릿에 필요한 추가 정보.
 @param completion  완료 핸들러. 호출에 실패할 경우 error가 전달 됨. 단, 최대 요청크기 초과 및 키키오톡 버전 미달 시에는 핸들러가 호출되기 전에 별도의 UIAlert이 노출 됨.
 */
- (void)talkLinkWithTemplateId:(SInt64)templateId args:(NSDictionary<NSString *, NSString *> *)args completion:(KLKTalkLinkCompletionHandler)completion;

@end
