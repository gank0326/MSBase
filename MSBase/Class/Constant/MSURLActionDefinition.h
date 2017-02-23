//
//  MSURLActionDefinition.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#ifndef MSURLActionDefinition_h
#define MSURLActionDefinition_h

/** 跳出一个测试界面 */
NS_INLINE MSURLAction *el_actionurl_test(DataItemDetail *dataDetail,NSString *userId) {
    NSString *actionURL = [NSString stringWithFormat:@"stockbar://TestViewController"];
    MSURLAction *action = [MSURLAction actionWithURLString:actionURL];
    [action setObject:dataDetail forKey:@"dataDetail"];
    [action setObject:userId forKey:@"userId"];
    return action;
}

/** H5界面 */
NS_INLINE MSURLAction *el_actionurl_h5(NSString *_Nullable navTitle, NSURL *URL) {
    NSString *actionURL = [NSString stringWithFormat:@"emlive://ELBasicH5Controller"];
    MSURLAction *action = [MSURLAction actionWithURLString:actionURL];
    [action setObject:navTitle forKey:@"navTitle"];
    [action setObject:URL forKey:@"h5URL"];
    return action;
}

#endif /* MSURLActionDefinition_h */
