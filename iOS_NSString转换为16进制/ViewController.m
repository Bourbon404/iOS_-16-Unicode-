//
//  ViewController.m
//  iOS_NSString转换为16进制
//
//  Created by Bourbon on 13-11-8.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self replaceUnicode1:@"\u8303\u5fb7\u8428"];
    int num = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%d",num);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickBackground:(id)sender
{
    [self.view endEditing:YES];
}

-(void)click:(id)sender
{
    NSString *textString = _text1.text;
    _text2.text = [self chineseToHex:textString];
}
-(void)click1:(id)sender
{
    NSString *string = [self changeLanguage:_text2.text];
    _text1.text = string;
}
-(void)click2:(id)sender
{
    int num = [_text1.text intValue];
    NSString *string = [self ToHex:num];
    _text2.text = string;
}


/**
 *  时间转换部分
 *
 //从1970年开始到现在经过了多少秒
 -(NSString *)getTimeSp
 {
 NSString *time;
 NSDate *fromdate=[NSDate date];
 time = [NSString stringWithFormat:@"%f",[fromdate timeIntervalSince1970]];
 return time;
 }
 
 //将时间戳转换成NSDate,转换的时间我也不知道是哪国时间,应该是格林尼治时间
 -(NSDate *)changeSpToTime:(NSString*)spString
 {
 NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
 NSLog(@"%@",confromTimesp);
 return confromTimesp;
 }
 
 //将时间戳转换成NSDate,加上时区偏移。这个转换之后是北京时间
 -(NSDate*)zoneChange:(NSString*)spString
 {
 NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
 NSTimeZone *zone = [NSTimeZone systemTimeZone];
 NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
 NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
 NSLog(@"%@",localeDate);
 return localeDate;
 }
 
 //比较给定NSDate与当前时间的时间差，返回相差的秒数
 -(long)timeDifference:(NSDate *)date
 {
 NSDate *localeDate = [NSDate date];
 long difference =fabs([localeDate timeIntervalSinceDate:date]);
 return difference;
 }
 
 //将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
 -(NSString*)nsdateToString:(NSDate *)date
 {
 NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
 [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 NSString* string=[dateFormat stringFromDate:date];
 NSLog(@"%@",string);
 return string;
 }
 
 //将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
 -(long)changeTimeToTimeSp:(NSString *)timeStr
 {
 long time;
 NSDateFormatter *format=[[NSDateFormatter alloc] init];
 [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 NSDate *fromdate=[format dateFromString:timeStr];
 time= (long)[fromdate timeIntervalSince1970];
 NSLog(@"%ld",time);
 return time;
 }
 
 //获取当前系统的yyyy-MM-dd HH:mm:ss格式时间
 -(NSString *)getTime
 {
 NSDate *fromdate=[NSDate date];
 NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
 [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 NSString* string=[dateFormat stringFromDate:fromdate];
 return string;
 }
 
 //将当前时间转化为年月日格式
 -(NSString *)changeDate
 {
 NSDate *date = [NSDate date];
 NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
 NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
 NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
 
 NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
 NSInteger year = [comps year];
 NSInteger month = [comps month];
 NSInteger day = [comps day];
 NSInteger hour = [comps hour];
 NSInteger min = [comps minute];
 NSInteger sec = [comps second];
 
 NSString *string = [NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",year,month,day,hour,min,sec];
 
 NSLog(@"%@",string);
 return string;
 }

 */


//发送数据时,16进制数－>Byte数组->NSData,加上校验码部分
-(NSData *)hexToByteToNSData:(NSString *)str
{
    int j=0;
    Byte bytes[[str length]/2];                         ////Byte数组即字节数组,类似于C语言的char[],每个汉字占两个字节，每个数字或者标点、字母占一个字节
    for(int i=0;i<[str length];i++)
    {
        /**
         *  在iphone/mac开发中，unichar是两字节长的char，代表unicode的一个字符。
         *  两个单引号只能用于char。可以采用直接写文字编码的方式来初始化。采用下面方法可以解决多字符问题
         */
        int int_ch;                                     ///两位16进制数转化后的10进制数
        unichar hex_char1 = [str characterAtIndex:i];   ////两位16进制数中的第一位(高位*16)
                
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
        {
            int_ch1 = (hex_char1-48)*16;                //// 0 的Ascll - 48
        }
        else if(hex_char1 >= 'A' && hex_char1 <='F')
        {
            int_ch1 = (hex_char1-55)*16;                //// A 的Ascll - 65
        }
        else
        {
            int_ch1 = (hex_char1-87)*16;                //// a 的Ascll - 97
        }
        
        i++;
        
        unichar hex_char2 = [str characterAtIndex:i];   ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
        {
            int_ch2 = (hex_char2-48);                   //// 0 的Ascll - 48
        }
        else if(hex_char2 >= 'A' && hex_char2 <='F')
        {
            int_ch2 = hex_char2-55;                     //// A 的Ascll - 65
        }
        else
        {
            int_ch2 = hex_char2-87;                     //// a 的Ascll - 97
        }
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;                              ///将转化后的数放入Byte数组里
        
//        if (j==[str length]/2-2) {
//            int k=2;
//            int_ch=bytes[0]^bytes[1];
//            while (k
//                int_ch=int_ch^bytes[k];
//                k++;
//            }
//            bytes[j] = int_ch;
//        }
        
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[str length]/2 ];
    NSLog(@"%@",newData);
    return newData;
}
//接收数据时,NSData－>Byte数组->16进制数
-(NSString *)NSDataToByteTohex:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数,与 0xff 做 & 运算会将 byte 值变成 int 类型的值，也将 -128～0 间的负值都转成正值了。
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    NSLog(@"hexStr:%@",hexStr);
    return hexStr;
}
//将汉字字符串转换成16进制字符串
-(NSString *)chineseToHex:(NSString*)chineseStr
{
    NSStringEncoding encodingGB18030= CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *responseData =[chineseStr dataUsingEncoding:encodingGB18030 ];
    NSString *string=[self NSDataToByteTohex:responseData];
    NSLog(@"%@",string);
    return string;
}
//将汉字字符串转换成UTF8字符串
-(NSString *)chineseToUTf8Str:(NSString*)chineseStr
{
    NSStringEncoding encodingUTF8 = NSUTF8StringEncoding;
    NSData *responseData2 =[chineseStr dataUsingEncoding:encodingUTF8 ];
    NSString *string=[self NSDataToByteTohex:responseData2];
    return string;
}
//将十六进制字符串转换成汉字
-(NSString*)changeLanguage:(NSString*)chinese
{
    NSString *strResult;
    NSLog(@"chinese:%@",chinese);
    if (chinese.length%2==0)
    {
        //第二次转换
        NSData *newData = [self hexToByteToNSData:chinese];
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        strResult = [[NSString alloc] initWithData:newData encoding:encode];
        NSLog(@"strResult:%@",strResult);
    }
    else
    {
        NSString *strResult = @"已假定是汉字的转换，所传字符串的长度必须是4的倍数!";
        NSLog(@"%@",strResult);
        return NULL;
    }
    return strResult;
}
/////////////GBK,汉字，GB2312,ASCII码，UTF8,UTF16
//UTF8字符串转换成汉字
-(NSString*)changeLanguageUTF8:(NSString*)chinese
{
    NSString *strResult;
    NSData *data=[self hexToByteToNSData:chinese];
    strResult=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return strResult;
}
//将十进制数转换成十六进制
-(NSString *)ToHex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++)
    {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0)
        {
            break;
        }
        
    }
    return str;
}




//Unicode转化为汉字
- (NSString *)replaceUnicode1:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    NSLog(@"%@",[returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"]);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}


//iso8859－1 到 unicode编码转换       iso8859-1字符编码的一种
/*
- (NSString *)changeISO88591StringToUnicodeString:(NSString *)iso88591String
{
    NSMutableString *srcString = [[NSMutableString alloc]initWithString:iso88591String];
    [srcString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    [srcString replaceOccurrencesOfString:@"&#x" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    NSMutableString *desString = [[NSMutableString alloc]init];
    NSArray *arr = [srcString componentsSeparatedByString:@";"];    //将字符串切割成数组
    for(int i=0;i<[arr count]-1;i++)
    {
        NSString *v = [arr objectAtIndex:i];
        char *c = malloc(3);
        int value = [StringUtil changeHexStringToDecimal:v];//将二进制转化为十进制
        c[1] = value  &0x00FF;
        c[0] = value >>8 &0x00FF;
        c[2] = '\0';
        [desString appendString:[NSString stringWithCString:c encoding:NSUnicodeStringEncoding]];
        free(c);
    }
    return desString;
}
 */
@end





















