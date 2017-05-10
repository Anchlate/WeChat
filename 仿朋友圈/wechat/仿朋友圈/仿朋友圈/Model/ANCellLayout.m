
//
//  ANCellLayout.m
//  仿朋友圈
//
//  Created by Qianrun on 16/11/30.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "ANCellLayout.h"
#import "ANDefine.h"

@implementation ANCellLayout
/*
 
 // 1.
 avatar: http://tp2.sinaimg.cn/1829483361/50/5753078359/1
 
 
 // 2.
 content: 近日[心]，adidas Originals为经典鞋款Stan Smith打造Primeknit版本，并带来全新的“OG”系列。简约的鞋身采用白色透气Primeknit针织材质制作，再将Stan Smith代表性的绿、红、深蓝三个元年色调融入到鞋舌和后跟点缀，最后搭载上米白色大底来保留其复古风味。据悉该鞋款将在今月登陆全球各大adidas Originals指定店舖。
 
 
 // 3.
 date: 2016-04-03 07:28:00 +0000
 
 
 // 4. 
 imgs: (
     "http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hgxij20lo0egwgc.jpg",
     "http://ww3.sinaimg.cn/mw690/6d0bb361gw1f2jim2hsg6j20lo0egwg2.jpg",
     "http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2d7nfj20lo0eg40q.jpg",
     "http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2hka3j20lo0egdhw.jpg",
     "http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hq61j20lo0eg769.jpg"
 )
 
 
 // 5.
 name: SIZE潮流生活
 
 
 // 6.
 statusID: 1
 
 // 7.
 commentList: (
  {
     content = "\U4f7f\U7528LWAsyncDisplay\U6765\U5b9e\U73b0\U56fe\U6587\U6df7\U6392\U3002\U4eab\U53d7\U5982\U4e1d\U822c\U987a\U6ed1\U7684\U6eda\U52a8\U4f53\U9a8c\U3002";
     from = "SIZE\U6f6e\U6d41\U751f\U6d3b";
     to = "";
    },
  {
     content = "\U54c8\U54c8\U54c8\U54c8";
     from = waynezxcv;
     to = "SIZE\U6f6e\U6d41\U751f\U6d3b";
    },
  {
     content = "nice~\U4f7f\U7528LWAsyncDisplayView\U3002\U652f\U6301\U5f02\U6b65\U7ed8\U5236\Uff0c\U8ba9\U6eda\U52a8\U5982\U4e1d\U822c\U987a\U6ed1\U3002\U5e76\U4e14\U652f\U6301\U56fe\U6587\U6df7\U6392[\U5fc3]\U548c\U70b9\U51fb\U94fe\U63a5#LWAsyncDisplayView#";
     from = "SIZE\U6f6e\U6d41\U751f\U6d3b";
     to = waynezxcv;
    }
 )
 
 */

- (id)init {
    
    self = [super init];
    if (self) {
        
        // avatar
        self.avatar = @"http://tp2.sinaimg.cn/1829483361/50/5753078359/1";
        
        // name
        NSString *name = @"SIZE潮流生活";
        
        // conetent
        NSString *content = @"近日[心]，adidas Originals为经典鞋款Stan Smith打造Primeknit版本，并带来全新的“OG”系列。简约的鞋身采用白色透气Primeknit针织材质制作，再将Stan Smith代表性的绿、红、深蓝三个元年色调融入到鞋舌和后跟点缀，最后搭载上米白色大底来保留其复古风味。据悉该鞋款将在今月登陆全球各大adidas Originals指定店舖。";
        
        // imgs
        NSArray *imgs = @[
                          @"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hgxij20lo0egwgc.jpg",
                          @"http://ww3.sinaimg.cn/mw690/6d0bb361gw1f2jim2hsg6j20lo0egwg2.jpg",
                          @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2d7nfj20lo0eg40q.jpg",
                          @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2hka3j20lo0egdhw.jpg",
                          @"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hq61j20lo0eg769.jpg"
                          ];
        
        // date
        NSDate *date = [NSDate date];
        
        // commentList
        NSDictionary *comment1 = @{
                                   @"content" : @"内容",
                                   @"from" : @"来自",
                                   @"to" : @"A1"
                                   };
        
        NSDictionary *comment2 = @{
                                   @"content" : @"内容2",
                                   @"from" : @"来自2",
                                   @"to" : @"A2"
                                   };
        
        NSDictionary *comment3 = @{
                                   @"content" : @"内容3",
                                   @"from" : @"来自3",
                                   @"to" : @"A3"
                                   };
        
        NSArray *commentList = @[comment1, comment2, comment3];
        
        
        static NSDateFormatter* dateFormatter;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
            
        });
        
        //avatar
        self.avatarPosition = CGRectMake(0.0f, 0.0f,40.0f, 40.0f);
        
        //name
        self.nameTextLayout = [[ANTextLayout alloc] init];
        self.nameTextLayout.text = name;
        self.nameTextLayout.font = [UIFont systemFontOfSize:15.0f];
        self.nameTextLayout.textAlignment = NSTextAlignmentLeft;
        self.nameTextLayout.linespace = 2.0f;
        self.nameTextLayout.textColor = RGB(113, 129, 161, 1);
        self.nameTextLayout.boundsRect = CGRectMake(60, 20, SCREEN_WIDTH, 20);
        [self.nameTextLayout creatCTFrameRef];
        
        [self.nameTextLayout addLinkWithData:name
                                     inRange:NSMakeRange(0, name.length)
                                   linkColor:nil
                              highLightColor:[UIColor grayColor]
                              UnderLineStyle:NSUnderlineStyleNone];
        
        //content
        self.contentTextLayout = [[ANTextLayout alloc] init];
        self.contentTextLayout.text = content;
        self.contentTextLayout.font = [UIFont systemFontOfSize:15.0f];
        self.contentTextLayout.textColor = RGB(40, 40, 40, 1);
        self.contentTextLayout.boundsRect = CGRectMake(60.0f,50.0f,SCREEN_WIDTH - 80.0f,MAXFLOAT);
        self.contentTextLayout.linespace = 2.0f;
        [self.contentTextLayout creatCTFrameRef];
        
#warning message
        //解析表情跟主题（[emoji] - > 表情。。#主题# 添加链接）
        /*
        [LWTextParser parseEmojiWithTextLayout:self.contentTextLayout];
        [LWTextParser parseTopicWithTextLayout:self.contentTextLayout
                                     linkColor:RGB(113, 129, 161, 1)
                                highlightColor:nil
                                underlineStyle:NSUnderlineStyleNone];
        */
        
        //imgs
        NSInteger imageCount = [imgs count];
        NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSInteger row = 0;
        NSInteger column = 0;
        for (NSInteger i = 0; i < imgs.count; i ++) {
            CGRect imageRect = CGRectMake(60.0f + (column * 85.0f),
                                          60.0f + self.contentTextLayout.textHeight + (row * 85.0f),
                                          80.0f,
                                          80.0f);
            NSString* rectString = NSStringFromCGRect(imageRect);
            [tmpArray addObject:rectString];
            column = column + 1;
            if (column > 2) {
                column = 0;
                row = row + 1;
            }
        }
        CGFloat imagesHeight = 0.0f;
        row < 3 ? (imagesHeight = (row + 1) * 85.0f):(imagesHeight = row  * 85.0f);
        self.imagePostionArray = tmpArray;
        //timeStamp
        self.dateTextLayout = [[ANTextLayout alloc] init];
        self.dateTextLayout.text = [dateFormatter stringFromDate:date];
        self.dateTextLayout.font = [UIFont systemFontOfSize:13.0f];
        self.dateTextLayout.textColor = [UIColor grayColor];
        self.dateTextLayout.boundsRect = CGRectMake(60, 70 + imagesHeight + self.contentTextLayout.textHeight,
                                                    SCREEN_WIDTH - 80,
                                                    20.0f);
        [self.dateTextLayout creatCTFrameRef];
        //menu
        self.menuPosition = CGRectMake(SCREEN_WIDTH - 40.0f,
                                       70.0f + self.contentTextLayout.textHeight + imagesHeight,
                                       20.0f,
                                       15.0f);
        //comment
        self.commentBgPosition = CGRectZero;
        self.commentTextLayouts = @[];
        CGRect rect = CGRectMake(60.0f, 70.0f + self.contentTextLayout.textHeight + imagesHeight + 25.0f, SCREEN_WIDTH - 80, 20);
        CGFloat offsetY = 0.0f;
        if (commentList.count != 0 && commentList != nil) {
            NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:commentList.count];
            for (NSDictionary* commentDict in commentList) {
                NSString* to = commentDict[@"to"];
                if (to.length != 0) {
                    NSString* commentString = [NSString stringWithFormat:@"%@回复%@:%@",commentDict[@"from"],commentDict[@"to"],commentDict[@"content"]];
                    ANTextLayout* commentLayout = [[ANTextLayout alloc] init];
                    commentLayout.text = commentString;
                    commentLayout.font = [UIFont systemFontOfSize:14.0f];
                    commentLayout.textAlignment = NSTextAlignmentLeft;
                    commentLayout.linespace = 2.0f;
                    commentLayout.textColor = RGB(40, 40, 40, 1);
                    commentLayout.boundsRect = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, 20.0f);
                    [commentLayout creatCTFrameRef];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"from"]]
                                           inRange:NSMakeRange(0,[(NSString *)commentDict[@"from"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"to"]]
                                           inRange:NSMakeRange([(NSString *)commentDict[@"from"] length] + 2,[(NSString *)commentDict[@"to"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
                    
#warning message
                    /*
                    [LWTextParser parseEmojiWithTextLayout:commentLayout];
                    [LWTextParser parseTopicWithTextLayout:commentLayout
                                                 linkColor:RGB(113, 129, 161, 1)
                                            highlightColor:nil
                                            underlineStyle:NSUnderlineStyleNone];
                    */
                    
                    [tmp addObject:commentLayout];
                    offsetY += commentLayout.textHeight;
                } else {
                    NSString* commentString = [NSString stringWithFormat:@"%@:%@",commentDict[@"from"],commentDict[@"content"]];
                    ANTextLayout* commentLayout = [[ANTextLayout alloc] init];
                    commentLayout.text = commentString;
                    commentLayout.font = [UIFont systemFontOfSize:14.0f];
                    commentLayout.textAlignment = NSTextAlignmentLeft;
                    commentLayout.linespace = 2.0f;
                    commentLayout.textColor = RGB(40, 40, 40, 1);
                    commentLayout.boundsRect = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, 20.0f);
                    [commentLayout creatCTFrameRef];
                    
                    [commentLayout addLinkWithData:[NSString stringWithFormat:@"%@",commentDict[@"from"]]
                                           inRange:NSMakeRange(0,[(NSString *)commentDict[@"from"] length])
                                         linkColor:RGB(113, 129, 161, 1)
                                    highLightColor:[UIColor grayColor]
                                    UnderLineStyle:NSUnderlineStyleNone];
#warning message
                    /*
                    [LWTextParser parseEmojiWithTextLayout:commentLayout];
                    [LWTextParser parseTopicWithTextLayout:commentLayout
                                                 linkColor:RGB(113, 129, 161, 1)
                                            highlightColor:nil
                                            underlineStyle:NSUnderlineStyleNone];
                     */
                    
                    [tmp addObject:commentLayout];
                    offsetY += commentLayout.textHeight;
                }
            }
            self.commentTextLayouts = tmp;
            self.commentBgPosition = CGRectMake(60.0f, 70.0f + self.contentTextLayout.textHeight + imagesHeight + 25.0f, SCREEN_WIDTH - 80, offsetY + 15.0f);
        }
        //cellHeight
        self.cellHeight = 100.0f + imagesHeight + self.contentTextLayout.textHeight + self.commentBgPosition.size.height + 5.0f;
    }
    return self;
}

@end
