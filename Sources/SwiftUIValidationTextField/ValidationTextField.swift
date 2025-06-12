//
//  ValidationTextField.swift
//  octave
//
//  Created by Kevin Raddatz on 11.06.25.
//

import SwiftUI

public struct ValidationTextField: View {

    @Binding var text: String
    var placeholder: String
    var background: Color = .red.opacity(0.2)
    var font: Font = .body
    var errorFont: Font = .body
    var validator: (String) -> String?
    
    /// Create a ValidationTextField
    ///
    /// Shows a popover when there is an error
    ///
    /// - Parameters:
    ///   - text: Binding to the value of the text field
    ///   - placeholder: Text shown when the text field is empty
    ///   - background: Color of the background to be shown when there is an error
    ///   - font: Font of the text field
    ///   - errorFont: Font of the error popover
    ///   - validator: Take the current value of the text field and return an error message or nil

    public init(
        text: Binding<String>,
        placeholder: String,
        background: Color = .red.opacity(0.2),
        font: Font = .body,
        errorFont: Font = .body,
        validator: @escaping (String) -> String?,
    ) {
        self._text = text
        self.placeholder = placeholder
        self.background = background
        self.font = font
        self.errorFont = errorFont
        self.validator = validator
    }

    @State private var internalText: String = ""
    @State private var errorText: String? = nil
    @State private var showErrorPopover: Bool = false

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(
                placeholder,
                text: $internalText,
            )
            .font(font)
            .onChange(of: internalText) {
                errorText = validator(internalText)
                if errorText != nil {
                    showErrorPopover = true
                }
            }
            .font(.title)
            .background(errorText == nil ? .clear : background)
            .textFieldStyle(.plain)
            .popover(isPresented: $showErrorPopover, arrowEdge: .bottom) {
                if let msg = errorText {
                    Text(msg)
                        .font(errorFont)
                        .padding(8)
                }
            }
        }
        .onAppear {
            internalText = text
            errorText = validator(text)
            showErrorPopover = errorText != nil
        }
    }
}

#Preview {
    ValidationTextField(
        text: .constant(""),
        placeholder: "Test",
        background: .red.opacity(0.2),
        font: .body,
    ) { value in value.isEmpty ? "Must not be empty" : nil }
    .padding()
}
