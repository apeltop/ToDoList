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
 @header KNVService.h
 카카오내비 API 호출을 담당하는 클래스.
 */

#import <Foundation/Foundation.h>

@class KNVParams;

/*!
 @class KNVService
 @abstract 카카오내비 API 호출을 담당하는 클래스.
 */
@interface KNVService : NSObject

/*!
 카카오내비 앱을 호출하여 목적지를 공유합니댜.
 @param params 목적지 공유에 필요한 파라미터. (required)
 @param error 실행하는 도중 발생한 오류.
 */
+ (void)shareDestinationWithParams:(nonnull KNVParams *)params error:(NSError * _Nullable *_Nullable)error;

/*!
 카카오내비 앱을 호출하여 목적지까지 길안내를 실행합니다.
 @param params 목적지 길안내에 필요한 파라미터. (required)
 @param error 실행하는 도중 발생한 오류.
 */
+ (void)navigateWithParams:(nonnull KNVParams *)params error:(NSError * _Nullable * _Nullable)error;

/*!
 카카오내비 앱이 실행 가능한지 여부를 리턴합니다.
 */
+ (BOOL)canOpenKakaoNavi;

@end
