VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Caesar's Cipher"
   ClientHeight    =   4335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9060
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   9060
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame EncFrame 
      Caption         =   "Encrypt Text "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4095
      Left            =   120
      TabIndex        =   11
      Top             =   120
      Visible         =   0   'False
      Width           =   8775
      Begin VB.TextBox OutEncText 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1095
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   4
         Top             =   2760
         Width           =   8295
      End
      Begin VB.TextBox InPlainText 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   240
         MaxLength       =   1024
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   0
         Top             =   600
         Width           =   8295
      End
      Begin VB.TextBox ShiftNum 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1440
         MaxLength       =   2
         TabIndex        =   1
         Text            =   "3"
         Top             =   1800
         Width           =   735
      End
      Begin VB.CommandButton EncStartBtn 
         Caption         =   "&Encrypt"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3000
         TabIndex        =   2
         Top             =   1800
         Width           =   1455
      End
      Begin VB.CommandButton BackBtn 
         Caption         =   "&Back"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   7080
         TabIndex        =   3
         Top             =   1800
         Width           =   1455
      End
      Begin VB.Label Label5 
         Caption         =   "Enter Plain Text Here:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   14
         Top             =   360
         Width           =   2175
      End
      Begin VB.Label Label3 
         Caption         =   "Encrypted Text Generated Here:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   2520
         Width           =   2895
      End
      Begin VB.Label Label4 
         Caption         =   "Shift Number:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   12
         Top             =   1920
         Width           =   1335
      End
   End
   Begin VB.Frame OpFrame 
      Caption         =   "Operations "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4095
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   8775
      Begin VB.CommandButton ExitBtn 
         Caption         =   "E&xit"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   6960
         TabIndex        =   9
         Top             =   2760
         Width           =   1335
      End
      Begin VB.CommandButton DecBtn 
         Caption         =   "&Decrypt Text"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3720
         TabIndex        =   8
         Top             =   2760
         Width           =   1335
      End
      Begin VB.CommandButton EncBtn 
         Caption         =   "&Encrypt Text"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   600
         TabIndex        =   7
         Top             =   2760
         Width           =   1335
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "- Riyaz Ahemed Walikar"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5640
         TabIndex        =   10
         Top             =   3720
         Width           =   3015
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   $"Form1.frx":0442
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   480
         TabIndex        =   6
         Top             =   600
         Width           =   7815
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub BackBtn_Click()
EncFrame.Visible = False
OpFrame.Visible = True
End Sub


Private Sub EncBtn_Click()
OpFrame.Visible = False
EncFrame.Visible = True
End Sub


Private Sub EncStartBtn_Click()
If Len(InPlainText.Text) > 0 Then 'And Len(ShiftNum.Text) > 0 Then
    If IsShiftNumValid(ShiftNum.Text) Then
        OutEncText.Text = EncryptText(CleanText(InPlainText.Text), CInt(ShiftNum.Text))
    Else
        
    End If
Else
    MsgBox "Please enter text to be encrytped.", vbExclamation + vbOKOnly, "No Data"
    InPlainText.SetFocus
End If
End Sub


Private Function IsShiftNumValid(num As String) As Boolean
On Error GoTo oops
    Dim i As Integer
    i = CInt(num)
    If i > 26 Or i < 1 Then
        MsgBox "The shift number should be between 1 and 26!", vbOKOnly + vbExclamation, "Invalid Shift."
        IsShiftNumValid = False
    Else
        IsShiftNumValid = True
    End If
    Exit Function
oops:
    MsgBox "Invalid number.", vbCritical + vbOKOnly, "NaN"
    ShiftNum.SetFocus
    IsShiftNumValid = False
End Function

Private Function CleanText(data As String) As String 'to remove all non alphabetic characters
For i = 1 To Len(data)
    Dim p As Integer
    p = Asc(LCase(Mid(data, i, 1)))
    If p > 122 Or p < 97 Then
        p = 46 - ShiftNum
    End If
    out = out + Chr(p)
Next
CleanText = out
End Function

Private Function EncryptText(data As String, ShiftNum As Integer)
Dim i As Integer, out As String
out = ""
For i = 1 To Len(data)
    Dim p As Integer
    p = Asc(LCase(Mid(data, i, 1))) + ShiftNum
    If (p) > 122 Then
        p = p + shifnum - 123 + 97
    End If
    out = out + Chr(p)
Next
EncryptText = out
End Function



