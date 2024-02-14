/*---------------------------------------------------------------------------
 
 Modified 2024 by relikd
 
 Based on original version:
 
 https://github.com/epatel/pinch-objc
 
 Copyright (c) 2011-2012 Edward Patel
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---------------------------------------------------------------------------*/

#import "ZipEntry.h"


@implementation ZipEntry
@synthesize filepath;
@synthesize offset;
@synthesize method;
@synthesize sizeCompressed;
@synthesize sizeUncompressed;
@synthesize filenameLength;
@synthesize extraFieldLength;

- (NSString *)description {
    return [NSString stringWithFormat:@"<ZipEntry path=\"%@\" size=%u>", filepath, sizeUncompressed];
}

@end

@implementation NSArray (ZipEntry)

/// Find filename matching pattern and return shortest possible path (thus ignoring deeper nested files).
- (ZipEntry*)zipEntryWithPath:(NSString*)path {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"filepath LIKE %@", path];
    NSUInteger shortest = 99999;
    ZipEntry *bestMatch = nil;
    for (ZipEntry *entry in [self filteredArrayUsingPredicate:pred]) {
        if (shortest > entry.filepath.length) {
            shortest = entry.filepath.length;
            bestMatch = entry;
        }
    }
    return bestMatch;
}

@end
