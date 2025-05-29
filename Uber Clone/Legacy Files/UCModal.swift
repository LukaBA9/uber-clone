////
////  UCModal.swift
////  Uber Clone
////
////  Created by Luka on 21.5.25..
////
//
//import SwiftUI
//
//struct UCModal<Content: View>: View {
//    let content: Content
//    let frameSize: CGSize
//    
//    let minimizedScale: CGFloat
//    let maximizedScale: CGFloat
//    
//    @State private var heightOffset: CGFloat
//    @Binding var isExtended: Bool
//    
//    init(frameSize: CGSize, minimizedScale: CGFloat = 0.3, maximizedScale: CGFloat = 0.95, isExtended: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
//        self.content = content()
//        self.frameSize = frameSize
//        
//        self.maximizedScale = maximizedScale
//        self.minimizedScale = minimizedScale
//        
//        self._isExtended = isExtended
//        heightOffset = frameSize.height * minimizedScale
//    }
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 0, bottomTrailing: 0, topTrailing: 10))
//                .frame(width: frameSize.width, height: heightOffset)
//                .foregroundStyle(.background)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            if !isExtended {
//                                if gesture.translation.height < 0 {
//                                    heightOffset -= gesture.translation.height
//                                }
//                            } else {
//                                if gesture.translation.height > 0 {
//                                    heightOffset -= gesture.translation.height
//                                }
//                            }
//                        }
//                        .onEnded{ gesture in
//                            if !isExtended {
//                                if (heightOffset) > (frameSize.height / 3) {
//                                    withAnimation {
//                                        isExtended = true
//                                        heightOffset = frameSize.height * maximizedScale
//                                    }
//                                } else {
//                                    withAnimation {
//                                        heightOffset = frameSize.height * minimizedScale
//                                    }
//                                }
//                            } else {
//                                if heightOffset < (frameSize.height / 1.25) {
//                                    
//                                    withAnimation {
//                                        isExtended = false
//                                        heightOffset = frameSize.height * minimizedScale
//                                    }
//                                } else {
//                                    withAnimation {
//                                        heightOffset = frameSize.height * maximizedScale
//                                    }
//                                }
//                            }
//                        }
//                )
//                .onChange(of: isExtended, { _, _ in
//                    withAnimation {
//                        heightOffset = isExtended ? frameSize.height * maximizedScale : frameSize.height * minimizedScale
//                    }
//                })
//                .overlay {
//                    content
//                }
//        }
//    }
//}
